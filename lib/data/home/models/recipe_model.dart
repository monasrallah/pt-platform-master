class AllRecipeModel {
  List<RecipeModel> recipes;

  AllRecipeModel({required this.recipes});

  factory AllRecipeModel.fromJson(Map<String, dynamic> json) {
    List<RecipeModel> all = [];
    for (var element in (json['recipe'] as List<dynamic>)) {
      all.add(RecipeModel.fromJson(element as Map<String, dynamic>));
    }
    return AllRecipeModel(recipes: all);
  }
}

class AllSupplementsModel {
  List<RecipeModel> recipes;

  AllSupplementsModel({required this.recipes});

  factory AllSupplementsModel.fromJson(Map<String, dynamic> json) {
    List<RecipeModel> all = [];
    for (var element in (json['supplements'] as List<dynamic>)) {
      all.add(RecipeModel.fromJson(element as Map<String, dynamic>));
    }
    return AllSupplementsModel(recipes: all);
  }
}

class RecipeModel {
  int id;
  String image;
  int? time;
  String? name;
  String title;
  String description;
  List<String>? ingredients;

  RecipeModel({
    required this.id,
    required this.image,
    this.time,
    this.name,
    required this.title,
    required this.description,
    this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        image: json["image"],
        time: json["time"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        ingredients: json["ingredients"] != null
            ? List<String>.from(json["ingredients"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "time": time,
        "name": name,
        "title": title,
        "description": description,
        "ingredients": ingredients != null
            ? List<String>.from(ingredients!.map((x) => x))
            : [],
      };
}
