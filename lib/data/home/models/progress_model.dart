class AllProgressModel {
  List<ProgressModel> progress;

  AllProgressModel({required this.progress});

  factory AllProgressModel.fromJson(Map<String, dynamic> json) {
    List<ProgressModel> all = [];
    for (var element in (json['progress'] as List<dynamic>)) {
      all.add(ProgressModel.fromJson(element as Map<String, dynamic>));
    }
    return AllProgressModel(progress: all);
  }
}

class ProgressModel {
  double? weight;
  PercentageModel percentage;
  double? muscle;
  double? fat;
  double? water;
  double? activeCalories;
  double? steps;

  ProgressModel({
    this.weight,
    required this.percentage,
    this.muscle,
    this.fat,
    this.water,
    this.activeCalories,
    this.steps,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
        weight: json["weight"]?.toDouble(),
        percentage: PercentageModel.fromJson(json["percentage"]),
        muscle: json["muscle"]?.toDouble(),
        fat: json["fat"]?.toDouble(),
        water: json["water"]?.toDouble(),
        activeCalories: json["active_calories"]?.toDouble(),
        steps: json["steps"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "percentage": percentage.toJson(),
        "muscle": muscle,
        "fat": fat,
        "water": water,
        "active_calories": activeCalories,
        "steps": steps,
      };
}

class PercentageModel {
  double value;
  String type;

  PercentageModel({
    required this.value,
    required this.type,
  });

  factory PercentageModel.fromJson(Map<String, dynamic> json) =>
      PercentageModel(
        value: json["value"]?.toDouble(),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "type": type,
      };
}
