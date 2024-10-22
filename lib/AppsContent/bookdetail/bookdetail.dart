import 'package:dusomeapps/AppsContent/controller/book_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../composent/bookactionbtn.dart';
import 'HeaderWidget.dart';



class bookdetail extends StatelessWidget {
  final Book book;
  const bookdetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              //height: 500,
              color: Colors.deepPurpleAccent,
              child: Row(
                children: [
                  Expanded(
                      child:HeaderWidget(
                        imageUrl: book.imageUrl ?? '',
                        title: book.title ?? '',
                        description: book.description ?? '',
                        page: book.page.toString() ?? '',
                        language: book.language.toString() ?? '',
                        category: book.category ?? '',
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('About Book', style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                            book.description ?? '',
                    style: Theme.of(context).textTheme.labelMedium,)),
                    ],
                  ),
                  SizedBox(height:10,),
                  bookactionbtn(bookUrl: book.pdfPath! ,),
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}
