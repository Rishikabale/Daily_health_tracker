import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  var user = Rxn<GoogleSignInAccount>();

 
  Future<void> login() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        user.value = account;
        Get.offAllNamed('/dashboard'); 
      }
    } catch (e) {
      print("Error signing in: $e"); 
      Get.snackbar("Login Failed", e.toString());
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    user.value = null;
    Get.offAllNamed('/login');
  }
}