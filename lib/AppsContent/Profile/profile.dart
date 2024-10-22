import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

 class ProfilePage extends StatefulWidget {
   const ProfilePage({super.key});

   @override
   State<ProfilePage> createState() => _ProfilePageState();
 }

 class _ProfilePageState extends State<ProfilePage> {

   String? username;
   String? lastname;
   String? firstname;
   String? email;

   bool isLoading = false;
   XFile? imageFile;
   final ImagePicker picker = ImagePicker();
   void takePhoto(ImageSource source) async {
     final pickedFile = await picker.pickImage(
       source: source,
     );
     setState(() {
       imageFile = pickedFile;
     });
   }

   Future<void> updateProfile() async {
     if (firstname == null || lastname == null || email == null || imageFile == null) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Veuillez compléter tous les champs et sélectionner une photo.')),
       );
       return;
     }

     setState(() {
       isLoading = true; // Start loading
     });

     try {
       // Upload image to Firebase Storage
       final storageRef = FirebaseStorage.instance
           .ref()
           .child('profile_images/${FirebaseAuth.instance.currentUser!.uid}');
       await storageRef.putFile(File(imageFile!.path));
       final imageUrl = await storageRef.getDownloadURL();

       // Update user profile in Firebase Auth
       await FirebaseAuth.instance.currentUser!.updateProfile(
         displayName: '$firstname $lastname',
         photoURL: imageUrl,
       );

       // Optionally, update other user information in Firestore or Realtime Database

       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Profile updated successfully!')),
       );
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to update profile: $e')),
       );
     } finally {
       setState(() {
         isLoading = false; // Stop loading
       });
     }
   }

   @override
   void initState() {
     super.initState();
     _loadUserProfile();
   }

   Future<void> _loadUserProfile() async {
     final user = FirebaseAuth.instance.currentUser;
     if (user != null) {
       setState(() {
         username = user.displayName;
         email = user.email;
         // Assuming the photoURL is set in Firebase Auth
         imageFile = user.photoURL != null ? XFile(user.photoURL!) : null;
       });
     }
   }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.deepPurpleAccent,
         title: Center(
           child: Text(
             'Profile',
             style: TextStyle(
             fontWeight: FontWeight.bold,
              fontSize: 25.0,
           ),
         ),
       ),
       ),
       body: ListView(
         children: [
           SizedBox(height: 10,),
           ImageProfile(context),
           SizedBox(height: 10,),
           Padding(
             padding: EdgeInsets.all(15),
             child: Card(
               child:Center(
                 child: Column(
                   children: [
                     Text(username??'Username',
                       style: TextStyle(
                         fontSize: 25.0,
                         fontWeight: FontWeight.bold,
                       ),),
                     SizedBox(height: 7,),
                     Text(email??'Email not availabe')
                   ],
                 ),
               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.all(15),
             child:Card(
               child: Padding(
                 padding: EdgeInsets.all(10),
                 child: Column(
                   children: [
                     TextField(
                       onChanged: (value){
                         username= value;
                       },
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.account_circle_outlined),
                         border: OutlineInputBorder(),
                         labelText: 'Username',
                         labelStyle: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                           color: Colors.grey,
                         ),
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextField(
                       onChanged: (value){
                         lastname = value;
                       },
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.person),
                         border: OutlineInputBorder(),
                         labelText: 'Last name',
                         labelStyle: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                           color: Colors.grey,
                         ),
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextField(
                       onChanged: (value){
                         firstname = value;
                       },
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.email),
                         border: OutlineInputBorder(),
                         labelText: 'First name',
                         labelStyle: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                           color: Colors.grey,
                         ),
                       ),
                     ),
                     SizedBox(height: 10,),
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
                   ],
                 ),
               ),
             ),
           ),
              SizedBox(height: 10.0,),
           Padding(
             padding: EdgeInsets.all(25),
             child: InkWell(
               onTap: () {
                 updateProfile();
               },
               child: Container(
                 height: 40,
                 width: 20,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Colors.deepPurpleAccent
                 ),
                 child:Center(
                   child: Text('Update Profile'),
                 ),
               ),
             ),
           )

         ],
       ),
     );
   }


Widget ImageProfile(BuildContext context){
  return Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage: imageFile ==null
              ?AssetImage('assets/Images/profile.png')
              :NetworkImage(imageFile!.path) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  builder: (builder)=>bottomsheet(context));
            },
            child: Icon(Icons.camera_alt,color: Colors.deepPurpleAccent,size: 25.0,),
          ),
        ),
      ],
    ),
  );
}

Widget bottomsheet(BuildContext context) {
  return Container(
    height: 100.0,
    width: MediaQuery
        .of(context)
        .size
        .width,
    margin: EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 20.0,
    ),
    child: Column(
      children: [
        Text('choose profile photo',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              takePhoto(ImageSource.camera);
            }, icon: Icon(Icons.camera),
            ),
            SizedBox(width: 15.0,),
            IconButton(onPressed: () {
              takePhoto(ImageSource.gallery);
            }, icon: Icon(Icons.image),
            ),
          ],
        )
      ],
    ),
  );
}
}

