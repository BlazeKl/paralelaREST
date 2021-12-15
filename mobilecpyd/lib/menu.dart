import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class GeneralMenu extends StatelessWidget {
//   //const GeneralMenu({Key? key}) : super(key: key);

//   static const appTitle = 'Drawer Demo';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: appTitle,
//       home: Text('hola'),
//     );
//   }
// }

class GeneralMenu extends StatelessWidget {
  const GeneralMenu({Key? key, required this.correo, required this.hashcode})
      : super(key: key);

  final String correo;
  final String hashcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mi titulo')),
      body: const Center(
        child: Text('MY PAGE!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(correo),
            ),
            ListTile(
              title: const Text('Lista Estaciones'), //Añadir la clase corresp
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Estimacion'), //Añadir la clase corresp
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Nosotros'), //Añadir la clase corresp
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log out'), //Añadir la clase corresp
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}// Clase de menu principal

// class ListadoEstaciones extends StatelessWidget {




// }// Clase para Listar las Estaciones

// class DetalleEstacion extends StatelessWidget {




// }// Clase para mostrar el Detalle de una estacion

// class Estimacion extends StatelessWidget {




// }// Clase para mostrar la estimacion diaria

// class Nosotros extends StatelessWidget {




// }// Clase para mostrar al grupo de integrantes

// class Logout extends StatelessWidget {


// }// Clase para hacer el log out y volver al menu principal del log in