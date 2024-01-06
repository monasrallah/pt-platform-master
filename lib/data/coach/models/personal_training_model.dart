import '../../home/models/recipe_model.dart';
import 'challenge_model.dart';

class AllAssignedWorkoutsModel {
  List<ChallengeModel> challenges;

  AllAssignedWorkoutsModel({required this.challenges});

  factory AllAssignedWorkoutsModel.fromJson(Map<String, dynamic> json) {
    List<ChallengeModel> all = [];
    for (var element in (json['workout'] as List<dynamic>)) {
      all.add(ChallengeModel.fromJson(element as Map<String, dynamic>));
    }
    return AllAssignedWorkoutsModel(challenges: all);
  }
}

class AllAssignedMealsModel {
  List<RecipeModel> meals;

  AllAssignedMealsModel({required this.meals});

  factory AllAssignedMealsModel.fromJson(Map<String, dynamic> json) {
    List<RecipeModel> all = [];
    for (var element in (json['meals'] as List<dynamic>)) {
      all.add(RecipeModel.fromJson(element as Map<String, dynamic>));
    }
    return AllAssignedMealsModel(meals: all);
  }
}

class PersonalizedModel {
  List<DataModel> video;
  List<DataModel> image;
  List<DataModel> pdf;
  List<DataModel> freeText;

  PersonalizedModel({
    required this.video,
    required this.image,
    required this.pdf,
    required this.freeText,
  });

  factory PersonalizedModel.fromJson(Map<String, dynamic> json) =>
      PersonalizedModel(
        video: List<DataModel>.from(
            json["video"].map((x) => DataModel.fromJson(x))),
        image: List<DataModel>.from(
            json["image"].map((x) => DataModel.fromJson(x))),
        pdf:
            List<DataModel>.from(json["pdf"].map((x) => DataModel.fromJson(x))),
        freeText: List<DataModel>.from(
            json["free_text"].map((x) => DataModel.fromJson(x))),
      );
}

class DataModel {
  int id;
  String value;

  DataModel({
    required this.id,
    required this.value,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json["id"],
        value: json["value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
