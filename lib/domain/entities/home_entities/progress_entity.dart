class ProgressEntity {
  double weight;
  PercentageEntity percentage;
  double muscle;
  double fat;
  double water;
  double activeCalories;
  double steps;

  ProgressEntity({
    required this.weight,
    required this.percentage,
    required this.muscle,
    required this.fat,
    required this.water,
    required this.activeCalories,
    required this.steps,
  });

  factory ProgressEntity.init() {
    return ProgressEntity(
        percentage: PercentageEntity(value: 0, type: ""),
        weight: 0,
        muscle: 0,
        fat: 0,
        water: 0,
        activeCalories: 0,
        steps: 0);
  }
}

class PercentageEntity {
  double value;
  String type;

  PercentageEntity({
    required this.value,
    required this.type,
  });
}
