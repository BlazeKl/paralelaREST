import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Controller extends GetxController {
  var _googleSigning = GoogleSignIn();
  var account = Rx<GoogleSignInAccount?>(null);

  login() async {
    try {
      account.value = await _googleSigning.signIn(); // Intentar inicio de sesion, exclusivo a dominio utem.cl
    } catch (a) { // Interceptar errores de login para desplegar mensaje de error
      Fluttertoast.showToast(
          msg: "Este dominio no tiene permitido iniciar sesión",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  logout() async {
    account.value = await _googleSigning.signOut(); // Funcion de logout
  }
}
