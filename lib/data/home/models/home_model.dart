import 'package:pt_platform/data/auth/models/coach_model.dart';

class CoachModel {
  int id;
  String firstName;
  String lastName;
  String avatar;
  String logo;
  bool isSubscription;
  List<CategoryModel> categories;
  List<TipModel> tips;

  CoachModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.logo,
    required this.isSubscription,
    required this.categories,
    required this.tips,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) => CoachModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        logo: json["logo"],
        isSubscription: json["is_subscription"],
        categories: List<CategoryModel>.from(json["categories"].map((x) => x)),
        tips:
            List<TipModel>.from(json["tips"].map((x) => TipModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "logo": logo,
        "is_subscription": isSubscription,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tips": List<TipModel>.from(tips.map((x) => x.toJson())),
      };
}
