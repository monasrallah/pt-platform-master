class AddCalenderParams {
  int timeId;
  String coachId;

  AddCalenderParams({required this.timeId, required this.coachId});

  Map<String, dynamic> toJson() => {
        "time_id": timeId,
        "coach_id": coachId,
      };
}
