import 'package:dusomeapps/AppsContent/Admin/home.dart';
import 'package:dusomeapps/Authentification/login/FooterWidget.dart';
import 'package:dusomeapps/Authentification/login/Forget-Password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}
   late Color myColor;
 class _loginscreenState extends State<loginscreen> {
   String? email;
   String? password;
   bool showSpiner = false;
   final _auth = FirebaseAuth.instance;

   User? loggedInUser;
   void getCurrentUser() async{
     try{
       final user =await _auth.currentUser;
       if(user != null){
         loggedInUser = user;
       }}
     catch(e){
       print(loggedInUser!.email);
     }
   }
  @override

  Widget build(BuildContext context) {

    myColor = Theme.of(context).primaryColor;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
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
              padding: EdgeInsets.only(top: 400.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: myColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value){
                              email = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.check, color: Colors.grey),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            onChanged: (value){
                              password = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.remove_red_eye, color: Colors.grey),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                forgetPasswordScreen.buildShowModalBottomSheet(context);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: myColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(myColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  showSpiner = true;
                                });
                                try {
                                  final user = await _auth
                                      .signInWithEmailAndPassword(
                                      email: email!, password: password!);
                                  if(user !=null){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage())
                                    );
                                  }
                                }on FirebaseAuthException catch(e){
        
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Aucun utilisateur trouvé avec cet e-mail.')));
        
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Mot de passe incorrect.')));
        
                                  }
        
                                }catch(e){
                                  print('Une erreur s\'est produite : $e');
                                }
                                setState(() {
                                  showSpiner = false;
                                });
        
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          LoginFooterWidget(),
                        ],
                      ),
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
