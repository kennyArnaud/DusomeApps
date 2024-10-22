import 'package:dusomeapps/AppsContent/composent/AuthController.dart';
import 'package:dusomeapps/Authentification/Signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});
  @override
  Widget build(BuildContext context) {
     AuthController authController = Get.put(AuthController());
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        SizedBox(
          child: OutlinedButton.icon(
            icon: Image(image: AssetImage('assets/google.png'), width: 20.0,),
            onPressed: (){
             authController.loginWithEmail();
            },
            label: Text('Sign-In with Google'),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => signupscreen()),
          );
        },
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                children: const[
                  TextSpan(
                    text: tSignup,
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
const String tDontHaveAnAccount = "Don't have an Account? ";
const String tSignup = "Signup";