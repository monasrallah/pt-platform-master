class AllSectionModel {
  List<SectionModel> sections;

  AllSectionModel({required this.sections});

  factory AllSectionModel.fromJson(Map<String, dynamic> json) {
    List<SectionModel> all = [];
    for (var element in (json['sections'] as List<dynamic>)) {
      all.add(SectionModel.fromJson(element as Map<String, dynamic>));
    }
    return AllSectionModel(sections: all);
  }
}

class SectionModel {
  int id;
  String title;
  List<CategoryExercisesModel> category;

  SectionModel({
    required this.id,
    required this.title,
    required this.category,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      SectionModel(
        id: json["id"],
        title: json["title"],
        category: List<CategoryExercisesModel>.from(
            json["category"].map((x) => CategoryExercisesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class CategoryExercisesModel {
  int id;
  String title;
  List<ExercisesModel> exercises;

  CategoryExercisesModel({
    required this.id,
    required this.title,
    required this.exercises,
  });

  factory CategoryExercisesModel.fromJson(Map<String, dynamic> json) =>
      CategoryExercisesModel(
        id: json["id"],
        title: json["title"],
        exercises: List<ExercisesModel>.from(
            json["exercises"].map((x) => ExercisesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class AllExercisesModel {
  List<ExercisesModel> exercises;

  AllExercisesModel({
    required this.exercises,
  });

  factory AllExercisesModel.fromJson(Map<String, dynamic> json) =>
      AllExercisesModel(
        exercises: List<ExercisesModel>.from(
            json["exercises"].map((x) => ExercisesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
      };
}

class ExercisesModel {
  int id;
  String title;
  String description;
  String icon;

  ExercisesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ExercisesModel.fromJson(Map<String, dynamic> json) => ExercisesModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "icon": icon,
      };
}
