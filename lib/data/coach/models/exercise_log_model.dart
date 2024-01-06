class AllExerciseLogsModel {
  List<ExerciseLogsModel> logs;

  AllExerciseLogsModel({required this.logs});

  factory AllExerciseLogsModel.fromJson(Map<String, dynamic> json) {
    List<ExerciseLogsModel> all = [];
    for (var element in (json['logs'] as List<dynamic>)) {
      all.add(ExerciseLogsModel.fromJson(element as Map<String, dynamic>));
    }
    return AllExerciseLogsModel(logs: all);
  }
}

class ExerciseLogsModel {
  int id;
  int number;
  int weight;
  String weightUnit;
  int repetition;
  String? note;
  String type;
  String createdAt;

  ExerciseLogsModel({
    required this.id,
    required this.number,
    required this.weight,
    required this.weightUnit,
    required this.repetition,
    required this.note,
    required this.type,
    required this.createdAt,
  });

  factory ExerciseLogsModel.fromJson(Map<String, dynamic> json) =>
      ExerciseLogsModel(
        id: json["id"],
        number: json["number"],
        weight: json["weight"],
        weightUnit: json["weight_unit"],
        repetition: json["repetition"],
        note: json["note"],
        type: json["type"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "weight": weight,
        "weight_unit": weightUnit,
        "repetition": repetition,
        "note": note,
        "type": type,
        "created_at": createdAt,
      };
}
