import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'connectapi.dart';
import 'lcontroller.dart';
import 'package:geocoding/geocoding.dart';

class GeneralMenu extends StatelessWidget {
  // Menu Dashboard con estaciones
  GeneralMenu({Key? key, required this.correo, required this.hashcode})
      : super(key: key);

  // Parametros recibidos por GeneralMenu
  final String correo;
  final String hashcode;

  var controller = Get.put(Controller());

  @override
  // define variables para realizar request a REST
  late Future<Tokenc> token = fetchToken(correo, hashcode); // informacion para request de token
  late Future<List<Estacion>> estaciones; // inicio para request de lista de estaciones

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(title: Text('Estaciones meteorológicas')),
      body: Center(
          child: FutureBuilder<Tokenc>(
        // realiza request de token
        future: token,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            estaciones = fetchEstaciones(snapshot.data!.token);
            return Container(
              // realiiza requeste de Estaciones, debe incluirse en container
              // para mantener token del request pasado
              child: FutureBuilder<List<Estacion>>(
                future: estaciones,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        // Itera la lista de estaciones
                        child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            key: UniqueKey(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(snapshot.data![index].nombre),
                                subtitle: Text('Latitud: ' +
                                    snapshot.data![index].latitud.toString() +
                                    '\n' +
                                    'Longitud: ' +
                                    snapshot.data![index].longitud.toString() +
                                    '\n' +
                                    'Altitud: ' +
                                    snapshot.data![index].altitud.toString() +
                                    ' Mts'),
                                onTap: () {
                                  // enrutador a google maps
                                  Navigator.of(context).push(_RoutM(
                                      snapshot.data![index].latitud.toString(),
                                      snapshot.data![index].longitud.toString(),
                                      snapshot.data![index].nombre));
                                },
                              ),
                            ));
                      },
                    ));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      )),
      // Menu de opciones, estimacion, about us y logout
      drawer: Drawer(
        backgroundColor: Colors.purple[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 80,
              child: DrawerHeader( //Menu burger aka Drawer
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
                child: Text(
                  correo,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text('Estimacion'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(_RoutE(token)); // enrutador a estmador
              },
            ),
            ListTile(
              title: const Text('Nosotros'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(_RoutN()); // enrutador a about us
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                Navigator.pop(context);
                controller.logout(); //Llama funcion logout en el controlador
              },
            )
          ],
        ),
      ),
    );
  }
}

//Enrutador para clase MapCreator
Route _RoutM(String lat, String lng, String nom) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MapCreator(
      lat: lat,
      lng: lng,
      nom: nom,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// Clase para crear el mapa de Google
// Para crear el detalle de la estación clickeada
class MapCreator extends StatefulWidget {
  @override
  MapCreator({required this.lat, required this.lng, required this.nom});

  final String lat;
  final String lng;
  final String nom;
  State<MapCreator> createState() =>
      MapCreatorState(lat: lat, lng: lng, nombre: nom);
}

// Clase para mapa de Google
class MapCreatorState extends State<MapCreator> {
  MapCreatorState({required this.lat, required this.lng, required this.nombre});
  // Recibe posicion para mapa de estaciones
  final String lat; //Latitud
  final String lng; //Longitud
  final String nombre; //Nombre Estacion
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  @override
  void initState() {
    initilize(lat, lng);
    super.initState();
  }

  // Marcador de posicion de la estacion
  initilize(String lat, String lng) {
    Marker a = Marker(
      markerId: MarkerId('Estación'),
      position: LatLng(double.parse(lat), double.parse(lng)),
    );
    markers.add(a);
    setState(() {});
  }

  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(lat), double.parse(lng)),
      zoom: 12,
    );
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Text(nombre),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          tooltip: 'Ir atras',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GoogleMap( //Parametros para ventana de google maps
        markers: markers.map((e) => e).toSet(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

// Enrutador para clase Estimaciones
Route _RoutE(Future<Tokenc> token) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        Estimacion(token: token),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// Clase para mostrar estimaciones

class Estimacion extends StatelessWidget {
  Estimacion({Key? key, required this.token}) : super(key: key);
  final Future<Tokenc> token; //Token para uso de Requests
  final _formKey = GlobalKey<FormState>();

  final micontroller =
      TextEditingController(); //Variable que guarda el texto de TextFormField

  @override
  late List<Location> location;
  late Future<Estimacion_c> est;
  Widget build(BuildContext context) {
    const title = 'Estimador';
    return Form(
      key: _formKey,
      child: Scaffold( //Creacion de menu de estimacion
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Colors.purple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            tooltip: 'Ir atras',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: TextFormField( // widget para ingresar texto
                controller: micontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Escriba una dirección';
                  }
                  return null;
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.search),
                label: Text('Buscar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) { // valida texto en TextFormField
                    try {
                      location = await locationFromAddress(micontroller.text);
                      String lat = location.first.latitude.toString();
                      String lng = location.first.longitude.toString();
                      showDialog(
                          context: context,
                          builder: (context) {
                            // Containers para realizar requests por frontend
                            return Container(child: FutureBuilder<Tokenc>(
                              future: token, //Request para obtener token
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  est = fetchEst(lat, lng, snapshot.data!.token);
                                  return Container(child: FutureBuilder<Estimacion_c>(
                                    future: est, //Request para obtener informacion meteorologica
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        // Ventana emergente AlertDialog()con la informacion
                                        return Container(child: AlertDialog(title: Text('Estimacion'),
                                          content: Text('Minima: ' + snapshot.data!.tmin.toString() + 
                                            '\nMaxina: ' + snapshot.data!.tmax.toString() +
                                            '\nPrecipitacion: ' + snapshot.data!.agua.toString())
                                        ),);
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }

                                      // By default, show a loading spinner.
                                      return const CircularProgressIndicator();
                                    },
                                  ));
                                  //return AlertDialog(title: Text(emax.toString()),);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }

                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ));
                          });
                    } catch (a) {
                      // interceptar errores en caso de que no se resuelve la direccion
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Direccion no valida'),
                      ));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Enrutador para clase Nosotros
Route _RoutN() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Nosotros(), //Widget para vista de Nosotros
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// Clase para mostrar al grupo de integrantes
class Nosotros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Nosotros';
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Colors.purple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            tooltip: 'Ir atras',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: const <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/profile/lalo.png'),
              ),
              title: Text('Javier Cisternas Cristi'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/profile/pipeta.png'),
              ),
              title: Text('Felipe Perez Cares'),
            ),
          ],
        ),
      ),
    );
  }
}
