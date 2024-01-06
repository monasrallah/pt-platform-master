class UpdateTargetParams {
  int target_calorie;
  int target_carb;
  int target_fat;
  int target_protein;

  UpdateTargetParams({
    required this.target_calorie,
    required this.target_carb,
    required this.target_fat,
    required this.target_protein,
  });

  Map<String, dynamic> toJson() => {
        "target_calorie": target_calorie,
        "target_carb": target_carb,
        "target_fat": target_fat,
        "target_protein": target_protein,
      };
}
