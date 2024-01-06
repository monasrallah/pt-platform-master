class AllBannerModel {
  List<BannerModel> banners;

  AllBannerModel({required this.banners});

  factory AllBannerModel.fromJson(Map<String, dynamic> json) {
    List<BannerModel> all = [];
    for (var element in (json['banners'] as List<dynamic>)) {
      all.add(BannerModel.fromJson(element as Map<String, dynamic>));
    }
    return AllBannerModel(banners: all);
  }
}

class BannerModel {
  int id;
  String image;
  String text;
  String url;

  BannerModel({
    required this.id,
    required this.image,
    required this.text,
    required this.url,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        image: json["image"],
        text: json["text"]??"",
        url: json["url"],
      );
}
