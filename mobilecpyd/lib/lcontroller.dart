import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Controller extends GetxController {
  var _googleSigning = GoogleSignIn();
  var account = Rx<GoogleSignInAccount?>(null);

  login() async {
    account.value = await _googleSigning.signIn();
  }
}
