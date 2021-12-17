import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lcontroller.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final controller = Get.put(Controller()); // Controlador para inicio de sesion por Google

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Login')),
      backgroundColor: Colors.purple[100],
      body: Center(
        child: Obx(() {
          if (controller.account.value == null) { // Si la informacion de login aun no existe, crear boton de login
            return BuildLoginButton();
          } else { // Si hay informacion de login, conectarse a API REST y resto de APP
            String account = controller.account.value?.email ?? '';
            String code = controller.account.value?.hashCode.toString() ?? '';
            createUser(account, code);
            return GeneralMenu( // Despliega DashBoard
              correo: account,
              hashcode: code,
            );
          }
        }), //child
      ), //body
    ); //Scaffold
  }

  FloatingActionButton BuildLoginButton() { // Boton de login con google
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
      },
      icon: Image.asset(
        'assets/images/logogoogle.png',
        height: 32,
        width: 32,
      ),
      label: Text('Log in con Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}

Future<http.Response> createUser(String email, String hcode) {
  return http.post(
    Uri.parse(
        'http://sugoidesuka.freeddns.us:3000/grupo-a/usuarios'), // Url a servidor dominio DDNS para uso por internet
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{ //body request rest
      'email': email,
      'password': hcode,
    }),
  );
}
