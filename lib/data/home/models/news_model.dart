class AllNewsModel {
  List<NewsModel> news;

  AllNewsModel({required this.news});

  factory AllNewsModel.fromJson(Map<String, dynamic> json) {
    List<NewsModel> all = [];
    for (var element in (json['news'] as List<dynamic>)) {
      all.add(NewsModel.fromJson(element as Map<String, dynamic>));
    }
    return AllNewsModel(news: all);
  }
}

class NewsModel {
  int id;
  String image;
  String title;
  String description;

  NewsModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "description": description,
      };
}
