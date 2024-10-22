import 'package:dusomeapps/Authentification/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'FooterWidget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class signupscreen extends StatefulWidget {

  static const String id = 'login_screen';


  State<signupscreen> createState() => _signupscreenState();
}
     late Color myColor;
class _signupscreenState extends State<signupscreen> {
  String? name;
  String? email;
  String? password;
  bool showSpiner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;

    return Scaffold(
      body:ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: myColor,
                image: DecorationImage(
                  image: AssetImage("assets/1.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      myColor.withOpacity(0.2), BlendMode.dstATop),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 380.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create account',
                          style: TextStyle(
                            color: myColor, fontSize: 32,fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextField(
                          onChanged: (value){
                            name= value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              label:Text('Username',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey),)
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                            email=value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              label:Text('Email',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey),)
                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        TextField(
                          onChanged:(value){
                            password=value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey,),
                              label:Text('Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.grey),)
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Column(
                          children: [
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(myColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color:myColor),
                                    ),
                                  ),
                                ),
                                onPressed: () async{
                                  setState(() {
                                    showSpiner = true;
                                  });
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(

                                        email: email!, password: password!);
                                    if(newUser != null){
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => loginscreen())
                                      );
                                    }
                                  } on FirebaseAuthException catch(e){
                                    if (e.code == 'weak-password') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('password est faible')));
                                    } else if (e.code == 'email-already-in-use') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Le compte existe déjà pour cet e-mail.')));
                                    }
                                  }catch (e){
                                    print('Une erreur s\'est produite : $e');
                                  }
                                  setState(() {
                                    showSpiner = false;
                                  });
                                },
                                child: Text('SignUp',
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
                        SizedBox(height: 10,),
                        SignupFooterWidget(),
                      ],
                    ),
                  ),

                ),
              ),
          ],
        ),
      ),
    );
  }
}
