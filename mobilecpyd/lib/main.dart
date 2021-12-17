import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'login.dart';
//import 'package:http/http.dart' as http;

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget { // Main de dart, deriva al resto de la aplicacion
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CPYD APP GRUPO A',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(), // Inicia funcion de login
    );
  }
}
