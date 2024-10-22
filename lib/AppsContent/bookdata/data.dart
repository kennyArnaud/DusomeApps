import 'package:dusomeapps/AppsContent/bookdata/bookModel.dart';

var categoryData = [
  {
    "icon": 'assets/Icons/heart.svg',
    "lebel": "ROMA",
  },
  {
    "icon": "assets/Icons/plane.svg",
    "lebel": "PHYSIQUE",
  },
  {
    "icon": "assets/Icons/world.svg",
    "lebel": "MATHEMATIQUE",
  },
  {
    "icon": "assets/Icons/heart.svg",
    "lebel": "INFORMATIQUE",
  },
  {
    "icon": "assets/Icons/world.svg",
    "lebel": "CHIMIE",
  },
  {
    "icon": "assets/Icons/plane.svg",
    "lebel": "BIOLOGIE",
  },
];

var bookData = [
  Bookmodel(
    title:" THE DISPARENCE OF EMILE ZOLA",
    description:"love, titarature",
    coverurl: "assets/Images/1.jpg",
    category: "ROMA",
    language: "ENGLISH",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',

  ),
  Bookmodel(

    title: "IN A LANDS OF PAPER GODS",
    description:"ACTION BOOK",
    coverurl: "assets/Images/4.jpg",
    category: "CHIMIE",
    language: "francais",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
  ),
  Bookmodel(
    title: "THE ZOO ",
    description:" LOVE ACTION BOOK",
    coverurl: "assets/Images/6.jpg",
    category: "BIOLOGIE",
    language: "francais",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
  ),
  Bookmodel(

    title: "the fatal of tree",
    description:"vangance book",
    coverurl: "assets/Images/12.jpg",
    category: "PHYSIQUE",
    language: "francais",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',

  ),

  Bookmodel(

    title: "WORD OF WAR",
    description:"MATHEMATIQUE BOOK",
    coverurl: "assets/Images/7.jpg",
    category: "MATHEMATIQUE",
    language: "francais",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',

  ),

  Bookmodel(

    title: "Tatle atle",
    description:"INFORMATIQUE BOOK",
    coverurl: "assets/Images/5.jpg",
    category: "INFORMATIQUE",
    language: "francais",
    page: 100,
    bookurl: 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
  ),
];
