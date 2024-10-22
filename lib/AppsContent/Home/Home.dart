import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dusomeapps/AppsContent/bookdata/data.dart';
import 'package:dusomeapps/AppsContent/controller/book_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bookdetail/bookdetail.dart';
import '../composent/bookTile.dart';
import '../composent/bookcard.dart';
import 'Home_content.dart';




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
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.deepPurpleAccent,
                height: 380,
                child: Column( // Changed from Expanded to Column
                  children: [
                    SizedBox(height: 40.0,),
                    HomeAAppsBAr(),
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        Text('Amahoro'),
                        SizedBox(width: 20.0,),
                        //  Text(username??'username')
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Flexible(child: Text('time to read and enhance')),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Search(),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Text('Categorie')
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryData
                            .map(
                              (e) => CategoryWidget(
                              iconPath: e["icon"]!,
                              btnName: e["lebel"]!), // Corrected "lebel" to "label"
                        )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
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
                    Row(
                    children: [
                    Text('Disponible',
                    style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    ),)
                    ],
                    ),
                    SizedBox(height: 5,),
                    SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                    children: books.map((e) => BookCard(
                    imageUrl: e.imageUrl!,
                    title: e.title!,
                    ontap: (){
                    Get.to(bookdetail(book: e));
                    }),
                    ).toList(),
                    ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                    children: [
                    Text('Autres Livres',
                    style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    ],
                    ),
                    SizedBox(height: 5.0,),
                    Column(
                    children: books.map((e) => BookTile(
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