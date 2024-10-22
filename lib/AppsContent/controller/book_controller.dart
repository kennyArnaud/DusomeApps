import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
   final dynamic title;
   final dynamic imageUrl;
   final dynamic pdfPath;
   final dynamic page;
   final dynamic description;
   final dynamic language;
  late final dynamic category;

   Book({
     required this.title,
     required this.description,
     required this.pdfPath,
     required this.imageUrl,
     required this.page,
     required this.language,
     required this.category,
   });

   factory Book.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Book(
      title: data['title'] ?? '',
      description: data['description'],
      pdfPath:data['pdfPath'],
      imageUrl: data['imageUrl'] ?? '',
      page: data['page'] ?? 0,
      language: data['language'] ?? '',
      category: data['category'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["description"] = description;
    _data["page"] = page;
    _data["language"] = language;
    _data["pdfPath"] = pdfPath;
    _data["category"] = category;
    _data["imageUrl"] = imageUrl;
    return _data;
  }
   factory Book.fromRealtimeDB(Map<dynamic, dynamic> data) {
     // print(data['language']); // Debugging print
     return Book(
       title: data['title'] ?? '',
       description: data['description'] ?? '',
       pdfPath: data['pdfPath'] ?? '',
       imageUrl: data['imageUrl'] ?? '',
       page: data['page'] ?? 0,
       language: data['language'] ?? '',
       category: data['category'] ?? '',
     );
   }

   @override
   String toString() {
     return 'Book(title: $title, description: $description, pdfPath: $pdfPath, imageUrl: $imageUrl, page: $page, language: $language, category: $category)';
   }

}
