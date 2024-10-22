import 'package:dusomeapps/AppsContent/BookPage/bookpage.dart';
import 'package:dusomeapps/AppsContent/bookdetail/bookdetail.dart';
import 'package:dusomeapps/AppsContent/composent/Favoris_page.dart';
import 'package:dusomeapps/AppsContent/controller/favoris_contoller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});


  Future<List<Favoris>> fetchBooks() async {
    List<Favoris> books = [];
    try {
      final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      dynamic key = FirebaseAuth.instance.currentUser?.uid;
      DatabaseEvent event = await databaseReference.child('favoritebooks').child(key).once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> booksData = event.snapshot.value as Map<dynamic, dynamic>;
        booksData.forEach((key, value) {
          books.add(Favoris.fromRealtimeDB(value));
        });
      }

    } catch (e) {
      print("Error fetching books: $e");
    }
    // print(books);
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Center(
          child: Text('Favoris'),
        ),
      ),
      body:  FutureBuilder<List<Favoris>>(
              future: fetchBooks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No books available'));
                } else {
                  List<Favoris> books = snapshot.data!;
                  
                  return SingleChildScrollView(

                    child: Column(
                        children: books.map((e) => BookFavoris(
                          title: e.title!,
                          imageUrl: e.imageUrl!,
                          page: e.page.toString(),
                          language: e.language!,
                          category: e.category!,
                          ontap: (){
                            print(e.pushkey);
                            //Get.to(bookpage(bookUrl: e));
                          },
                        )).toList()
                    ),
                  );
                }
              }

          )

    );
  }
}
