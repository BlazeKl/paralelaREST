import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lcontroller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Obx(() {
          if (controller.account.value == null)
            return BuildLoginButton();
          else
            return BuildMenu();
        }), //child
      ), //body
    ); //Scaffold
  }

  FloatingActionButton BuildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
      },
      icon: Image.asset(
        'assets/images/logogoogle.png',
        height: 32,
        width: 32,
      ),
      label: Text('Login con Google'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  Column BuildMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(controller.account.value?.email ?? ''),
        Text(controller.account.value?.hashCode.toString() ?? ''),
      ],
      // text: 'CPYD APP GRUPO A',
    );
  }
}
