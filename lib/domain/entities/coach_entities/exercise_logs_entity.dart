class ExerciseLogsEntity {
  int id;
  int number;
  int weight;
  String weightUnit;
  int repetition;
  String? note;
  String type;
  String createdAt;

  ExerciseLogsEntity({
    required this.id,
    required this.number,
    required this.weight,
    required this.weightUnit,
    required this.repetition,
    this.note,
    required this.type,
    required this.createdAt,
  });
}
