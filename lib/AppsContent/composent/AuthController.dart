import 'package:dusomeapps/AppsContent/Config/Messages.dart';
import 'package:dusomeapps/AppsContent/bottom_nav_bar.dart';
import 'package:dusomeapps/Authentification/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final auth = FirebaseAuth.instance;

  void loginWithEmail() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
      successMessage('Login Success');
      Get.offAll(MyBottomNavBar());
    } catch (ex) {
      print(ex);
      errorMessage("Error ! Try Agin");
    }
    isLoading.value = false;
  }

  void signout() async {
    await auth.signOut();
    successMessage('Logout');
    Get.offAll(loginscreen());
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      successMessage('Login Success');
      Get.offAll(MyBottomNavBar());
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      errorMessage(e.code);
    }
    isLoading.value = false;
  }

  Future<void> signupWithEmailPassword(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      successMessage('SignUp Success');
      Get.offAll(MyBottomNavBar());
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      errorMessage(e.code);
    }
    isLoading.value = false;
  }
}
