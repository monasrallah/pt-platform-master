class AllMeasurementsModel {
  List<MeasurementsModel> measurements;

  AllMeasurementsModel({required this.measurements});

  factory AllMeasurementsModel.fromJson(Map<String, dynamic> json) {
    List<MeasurementsModel> all = [];
    for (var element in (json['measurements'] as List<dynamic>)) {
      all.add(MeasurementsModel.fromJson(element as Map<String, dynamic>));
    }
    return AllMeasurementsModel(measurements: all);
  }
}

class MeasurementsModel {
  int id;
  DateTime date;
  double neck;
  double chest;
  double leftArm;
  double rightArm;
  double waist;
  double belly;
  double lowerBelly;
  double upperBelly;
  double hips;
  double leftThigh;
  double rightThigh;
  double liftCalf;
  double rightCalf;

  MeasurementsModel({
    required this.id,
    required this.date,
    required this.neck,
    required this.chest,
    required this.leftArm,
    required this.rightArm,
    required this.waist,
    required this.belly,
    required this.lowerBelly,
    required this.upperBelly,
    required this.hips,
    required this.leftThigh,
    required this.rightThigh,
    required this.liftCalf,
    required this.rightCalf,
  });

  factory MeasurementsModel.fromJson(Map<String, dynamic> json) =>
      MeasurementsModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        neck: json["neck"]?.toDouble(),
        chest: json["chest"]?.toDouble(),
        leftArm: json["left_arm"]?.toDouble(),
        rightArm: json["right_arm"]?.toDouble(),
        waist: json["waist"]?.toDouble(),
        belly: json["belly"]?.toDouble(),
        lowerBelly: json["lower_belly"]?.toDouble(),
        upperBelly: json["upper_belly"]?.toDouble(),
        hips: json["hips"]?.toDouble(),
        leftThigh: json["left_thigh"]?.toDouble(),
        rightThigh: json["right_thigh"]?.toDouble(),
        liftCalf: json["lift_calf"]?.toDouble(),
        rightCalf: json["right_calf"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "neck": neck,
        "chest": chest,
        "left_arm": leftArm,
        "right_arm": rightArm,
        "waist": waist,
        "belly": belly,
        "lower_belly": lowerBelly,
        "upper_belly": upperBelly,
        "hips": hips,
        "left_thigh": leftThigh,
        "right_thigh": rightThigh,
        "lift_calf": liftCalf,
        "right_calf": rightCalf,
      };
}
