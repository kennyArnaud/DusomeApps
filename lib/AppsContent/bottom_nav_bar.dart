
import 'package:dusomeapps/AppsContent/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:dusomeapps/AppsContent/CategoriePage.dart';

import 'Favorite.dart';
import 'Profile/profile.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyButtomNavBarState();
}
 late Color myColor;
class _MyButtomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  List pages = const [
    HomePage(),
    FavoritePage(),
    CategoriePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    return Scaffold(
      extendBody: true,
      //appBar: AppBar(
        //centerTitle: true,
        //title: const Text("Home"),
     // ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              // backgroundColor: Colors.transparent,
              selectedItemColor: myColor,
              unselectedItemColor: Colors.black,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: "categorie"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
