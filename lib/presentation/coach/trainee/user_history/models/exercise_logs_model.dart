
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
    this.note,
    required this.type,
    required this.createdAt,
  });

  factory ExerciseLogsModel.fromMap(Map<String, dynamic> map) {
    return ExerciseLogsModel(
      id: testMap(map, 'id', 0),
      number: testMap(map, 'number', 0),
      weight: testMap(map, 'weight', 0),
      weightUnit: testMap(map, 'weight_unit', ''),
      repetition: testMap(map, 'repetition', 0),
      note: testMap(map, 'note', ''),
      type: testMap(map, 'type', ''),
      createdAt: testMap(map, 'created_at', ''),
    );
  }
}

dynamic testMap(
    Map<String, dynamic> documentsData, String key, dynamic replacement) {
  if (documentsData.containsKey(key)) {
    if (documentsData[key] != null) {
      return documentsData[key];
    } else {
      return replacement;
    }
  } else if (!documentsData.containsKey(key)) {
    return replacement;
  }
}
