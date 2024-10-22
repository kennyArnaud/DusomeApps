import 'package:dusomeapps/AppsContent/bottom_nav_bar.dart';
import 'package:dusomeapps/Authentification/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupFooterWidget extends StatelessWidget {

  const SignupFooterWidget({super.key});


  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null; // L'utilisateur a annulé la connexion

    }


    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(

      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,

    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [

        const Text("OR"),

        SizedBox(
          child: OutlinedButton.icon(

            icon: Image(image: AssetImage('assets/google.png'), width: 20.0,),
            onPressed: () async {
              User? user = await _signInWithGoogle();
              if (user != null) {
                // L'utilisateur est connecté avec succès
                // Vous pouvez naviguer vers une autre page ou afficher un message de succès
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyBottomNavBar())
                );
              }

            },
            label: Text('Sign-In with Google'),
          ),

        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(onPressed: (){
          Navigator.push(

            context,
            MaterialPageRoute(

                builder: (context) => loginscreen ()),
          );

        },

          child: Text.rich(
            TextSpan(

                text: tAlreadyHaveAnAccount,
                children: const[
                  TextSpan(

                    text: tLogin,
                    style: TextStyle(color: Colors.blue),
                  ),

                ]

            ),
          ),
        ),
      ],

    );
  }

}

const String tAlreadyHaveAnAccount = "Already have an Account? ";

const String tLogin = "Login";