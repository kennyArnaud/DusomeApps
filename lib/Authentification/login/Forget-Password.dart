import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class forgetPasswordScreen{

  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) =>Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Recovery',
                style: TextStyle(
                  color: Colors.black, fontSize: 32,fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  email = value; // Store the email input
                },
                decoration: InputDecoration(
                  label: Text(tEmail),
                  hintText: tEmail,
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 20.0,),
              Column(
                children: [
                  Container(
                    height: 65.0,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.black45),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password reset email sent')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      },
                      child: Text(tNext,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

const tDefaultSize = 30.0;
const String tEmail = 'Entrer votre Email';
const String tNext = 'Send Email';
String email = ''; // Add a variable to store the email6