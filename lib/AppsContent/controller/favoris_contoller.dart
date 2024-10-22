import 'package:cloud_firestore/cloud_firestore.dart';

class Favoris {

  final String ? pushkey;
  final String title;
  final String imageUrl;
  final String page;
  final String language;
  final String category;
  final String pdfPath;

  Favoris({
    this.pushkey ,
    required this.title,
    required this.imageUrl,
    required this.page,
    required this.language,
    required this.category,
    required this.pdfPath,
  });

  factory Favoris.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Favoris(
      pushkey: data["pushkey"],
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      page: data['page'] ?? 0,
      language: data['language'] ?? '',
      category: data['category'] ?? '',
        pdfPath: data['pdfPath']?? '',
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["page"] = page;
    _data["language"] = language;
    _data["category"] = category;
    _data["imageUrl"] = imageUrl;
    return _data;
  }
  factory Favoris.fromRealtimeDB(Map<dynamic, dynamic> data) {
    // print(data['language']); // Debugging print
    return Favoris(
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      page: data['page'] ?? 0,
      language: data['language'] ?? '',
      category: data['category'] ?? '',
        pdfPath: data['pdfPath']??'',
    );
  }

  @override
  String toString() {
    return 'Favoris(title: $title, imageUrl: $imageUrl, pdfPath: $pdfPath,page: $page, language: $language, category: $category)';
  }

}
