import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../BookPage/bookpage.dart';

class bookactionbtn extends StatelessWidget {
  final String bookUrl;
  const bookactionbtn({super.key, required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(25),
      child: Container(
        height: 60,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Get.to(bookpage(bookUrl: bookUrl,));
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/Icons/book.svg'),
                  SizedBox(width: 10.0,),
                  Text('READ BOOK', style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),)
                ],
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}
