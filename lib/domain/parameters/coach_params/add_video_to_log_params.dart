class AddVideoToLogParams {
  int videoId;
  String coachId;
  int number;
  int weight;
  String weightUnit;
  int repetition;
  String note;
  String type;

  AddVideoToLogParams({
    required this.videoId,
    required this.coachId,
    required this.number,
    required this.weight,
    required this.weightUnit,
    required this.repetition,
    required this.note,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "coach_id": coachId,
        "number": number,
        "weight": weight,
        "weight_unit": weightUnit,
        "repetition": repetition,
        "note": note,
        "type": type,
      };
}
