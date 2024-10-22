class Bookmodel{

  String? title;
  String? description;
  String? language;
  int? page;
  String? coverurl;
  String? bookurl;
  String? category;

  Bookmodel({

    this.title,
    this.description,
    this.language,
    this.page,
    this.coverurl,
    this.bookurl,
    this.category,
});
  Bookmodel.fromJson(Map<String, dynamic> json) {

    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["page"] is int) {
      page = json["page"];
    }
    if (json["language"] is String) {
      language = json["language"];
    }
    if (json["bookurl"] is String) {
      bookurl = json["bookurl"];
    }
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["coverurl"] is String) {
      coverurl = json["coverurl"];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["description"] = description;
    _data["page"] = page;
    _data["language"] = language;
    _data["bookurl"] = bookurl;
    _data["category"] = category;
    _data["coverUrl"] = coverurl;
    return _data;
  }
}