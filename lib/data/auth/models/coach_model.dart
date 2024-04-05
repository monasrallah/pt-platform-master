class CoachesModel {
  List<CoachModel> coaches;

  CoachesModel({required this.coaches});

  factory CoachesModel.fromJson(Map<String, dynamic> json) {
    List<CoachModel> all = [];
    for (var element in (json['coaches'] as List<dynamic>)) {
      all.add(CoachModel.fromJson(element as Map<String, dynamic>));
    }
    return CoachesModel(coaches: all);
  }
}

class CoachModel {
  int id;
  String fullName;
  String nickName;
  String? email;
  String? description;
  String avatar;
  String? logo;
  String phoneNumber;
  String? role;
  bool? isSubscription;
  List<CategoryModel> categories;

  CoachModel({
    required this.id,
    required this.fullName,
    required this.nickName,
    required this.email,
    required this.avatar,
    required this.description,
    required this.phoneNumber,
    this.isSubscription,
    this.logo,
    required this.role,
    required this.categories,
  });

  factory CoachModel.fromJson(Map<String, dynamic> json) {
    if (json['role'] == 'user') {
      throw Exception(
          'you are trying to login with a different account type , back and change the account type');
    }
    return CoachModel(
      id: json["id"],
      fullName: json["full_name"],
      nickName: json["nick_name"],
      email: json["email"] ?? "",
      avatar: json["avatar"] ?? "",
      description: json["description"] ?? "",
      phoneNumber: json["phone_number"],
      role: json["role"],
      logo: json["logo"] as String?,
      isSubscription: json["is_subscription"] as bool?,
      categories: List<CategoryModel>.from(
          json["categories"].map((x) => CategoryModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "nick_name": nickName,
        "email": email,
        "avatar": avatar,
        "phone_number": phoneNumber,
        "role": role,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoriesModel {
  List<CategoryModel> categories;

  CategoriesModel({required this.categories});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> all = [];
    for (var element in (json['categories'] as List<dynamic>)) {
      all.add(CategoryModel.fromJson(element as Map<String, dynamic>));
    }
    return CategoriesModel(categories: all);
  }
}

class CategoryModel {
  int id;
  String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TipsModel {
  List<TipModel> tips;

  TipsModel({required this.tips});

  factory TipsModel.fromJson(Map<String, dynamic> json) {
    List<TipModel> all = [];
    for (var element in (json['categories'] as List<dynamic>)) {
      all.add(TipModel.fromJson(element as Map<String, dynamic>));
    }
    return TipsModel(tips: all);
  }
}

class TipModel {
  int id;
  int value;

  TipModel({
    required this.id,
    required this.value,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) => TipModel(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
