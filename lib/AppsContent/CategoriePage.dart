import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dusomeapps/AppsContent/bookdetail/bookdetail.dart';
import 'package:dusomeapps/AppsContent/composent/bookcard.dart';
import 'package:dusomeapps/AppsContent/controller/book_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {

    List<Map<String, dynamic>> _foundbooks = [];

    Future<List<Book>> fetchBooks() async {
      List<Book> books = [];
      try {
        final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
        DatabaseEvent event = await databaseReference.child('books').once();
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> booksData = event.snapshot.value as Map<dynamic, dynamic>;
          booksData.forEach((key, value) {
            books.add(Book.fromRealtimeDB(value));
          });
        }

      print("Fetched ${books.length} books");
    } catch (e) {
      print("Error fetching books: $e");
    }
    // print(books);
    return books;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurpleAccent,
      //   title: Center(
      //     child: Text(
      //         'Categorie',
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 25.0,
      //       ),
      //     ),
      //   ),
      // ),
      body:FutureBuilder<List<Book>>(
        future: fetchBooks(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('No books available'));
    } else {
      List<Book> books = snapshot.data!;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white12,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'search your favorite book',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    )
                ),
              ),

              SizedBox(height: 20.0,),
              Text('Roma',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'ROMA')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl!,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('CHIMIE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'CHIMIE')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl!,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('PHYSIQUE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'PHYSIQUE')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl!,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('MATHEMATIQUE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'MATHEMATIQUE')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl!,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('INFORMATIQUE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'INFORMATIQUE')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
              SizedBox(height: 10.0,),
              Text('BIOLOGIE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              SizedBox(height: 10.0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: books
                      .where((e) => e.category == 'BIOLOGIE')
                      .map((e) =>
                      BookCard(
                        imageUrl: e.imageUrl!,
                        title: e.title!,
                        ontap: () {
                          Get.to(bookdetail(book: e));
                        },
                      ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    },
    )
    );
  }
}
