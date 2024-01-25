// ignore_for_file: non_constant_identifier_names

class UpdateProgressParams {
  double weight;
  double muscle;
  double fat;
  double water;
  double active_calories;
  double steps;

  UpdateProgressParams({
    required this.weight,
    required this.muscle,
    required this.fat,
    required this.water,
    required this.active_calories,
    required this.steps,
  });

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "muscle": muscle,
        "fat": fat,
        "water": water,
        "active_calories": active_calories,
        "steps": steps,
      };
}
