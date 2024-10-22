import 'package:dusomeapps/AppsContent/Admin/add_book.dart';
import 'package:dusomeapps/AppsContent/Admin/home.dart';
import 'package:dusomeapps/AppsContent/CategoriePage.dart';
import 'package:flutter/material.dart';
class STabBar extends StatelessWidget {
  const STabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('DusomeApps'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home,color: Colors.white,),

              ),
              Tab(
                icon: Icon(Icons.book,color: Colors.white,),

              ),
              Tab(
                icon: Icon(Icons.add_card_sharp,color: Colors.white,),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HomePage(),
            CategoriePage(),
            AddBook(),
          ],
        ),
      ),
    );
  }
}