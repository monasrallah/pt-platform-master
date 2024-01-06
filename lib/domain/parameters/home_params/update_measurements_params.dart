class UpdateMeasurementsParams {
  double neck;
  double chest;
  double left_arm;
  double right_arm;
  double waist;
  double belly;
  double lower_belly;
  double upper_belly;
  double hips;
  double left_thigh;
  double right_thigh;
  double lift_calf;
  double right_calf;

  UpdateMeasurementsParams({
    required this.neck,
    required this.chest,
    required this.left_arm,
    required this.right_arm,
    required this.waist,
    required this.belly,
    required this.lower_belly,
    required this.upper_belly,
    required this.hips,
    required this.left_thigh,
    required this.right_thigh,
    required this.lift_calf,
    required this.right_calf,
  });

  Map<String, dynamic> toJson() => {
        "neck": neck,
        "chest": chest,
        "left_arm": left_arm,
        "right_arm": right_arm,
        "waist": waist,
        "belly": belly,
        "lower_belly": lower_belly,
        "upper_belly": upper_belly,
        "hips": hips,
        "left_thigh": left_thigh,
        "right_thigh": right_thigh,
        "lift_calf": lift_calf,
        "right_calf": right_calf,
      };
}
