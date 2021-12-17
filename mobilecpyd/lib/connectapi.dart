import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Clase para almacenar token
class Tokenc {
  final String token; // token
  final String rtoken; // refresh token

  Tokenc({required this.token, required this.rtoken});

  factory Tokenc.fromJson(Map<String, dynamic> json) { // Tomar info de json enviado por REST
    return Tokenc(
      token: json['token'],
      rtoken: json['rtoken'],
    );
  }
}

// Rquest a REST para obtener token
Future<Tokenc> fetchToken(String email, String code) async {
  final response = await http.post(
    Uri.parse('http://sugoidesuka.freeddns.us:3000/grupo-a/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': code,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    return Tokenc.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    throw Exception('Login Error');
  }
}

// Clase para almacenar datos de estacion
class Estacion {
  final int codigo;
  final String nombre;
  final double latitud;
  final double longitud;
  final int altitud;
  // Informacion de estaciones meteorologicas
  Estacion({
    required this.codigo,
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.altitud,
  });

  factory Estacion.fromJson(Map<String, dynamic> json) { // Tomar info de json enviado por REST
    return Estacion(
      codigo: json['cod_estacion'],
      nombre: json['nombre'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      altitud: json['altitud'],
    );
  }
}

// Request a REST para obtener lista de estaciones
Future<List<Estacion>> fetchEstaciones(String token) async {
  final response = await http.get(
      Uri.parse('http://sugoidesuka.freeddns.us:3000/grupo-a/stations'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token', // Enviar token de Auth para realizar request
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    return parseEstacion(response.body);
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    throw Exception('Request failed');
  }
}

// Parse de lista para request muchas estaciones
List<Estacion> parseEstacion(String rbody) {
  final parsed = json.decode(rbody).cast<Map<String, dynamic>>();
  return parsed.map<Estacion>((json) => Estacion.fromJson(json)).toList();
}

// Clase para almacenar estimacion del dia
class Estimacion_c {
  final String tmax;
  final String tmin;
  final String agua;

  Estimacion_c({
    required this.tmax,
    required this.tmin,
    required this.agua,
  });

  factory Estimacion_c.fromJson(Map<String, dynamic> json) {
    return Estimacion_c(
      tmax: json['temp_max'].toString(),
      tmin: json['temp_min'].toString(),
      agua: json['precipitacion'].toString(),
    );
  }
}

// Request a REST para obtener lista de estaciones
Future<Estimacion_c> fetchEst(String lat, String lng, String token) async {
  final response = await http.get(
      Uri.parse(
          'http://sugoidesuka.freeddns.us:3000/grupo-a/$lat/$lng/estimate'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    return Estimacion_c.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    throw Exception('Request failed');
  }
}
