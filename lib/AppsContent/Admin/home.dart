import 'package:dusomeapps/AppsContent/Admin/bookTileAdm.dart';
import 'package:dusomeapps/AppsContent/Admin/TabBar.dart';
import 'package:dusomeapps/AppsContent/bookdetail/bookdetail.dart';
import 'package:dusomeapps/AppsContent/controller/book_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

    } catch (e) {
      print("Error fetching books: $e");
    }
    // print(books);
    return books;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder<List<Book>>(
                      future: fetchBooks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No books available'));
                        } else {
                          List<Book> books = snapshot.data!;
                          return  Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white12,
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'search your  book',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    )
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Column(
                                  children: books.map((e) => BookTille(
                                    title: e.title!,
                                    imageUrl: e.imageUrl!,
                                    page: e.page.toString(),
                                    language: e.language!,
                                    category: e.category!,
                                    ontap: (){
                                      Get.to(bookdetail(book: e));
                                    },
                                  )).toList()
                              )
                            ],
                          );
                        }}
                  )

              )
            ],
          )
      ),
    );

  }
}
