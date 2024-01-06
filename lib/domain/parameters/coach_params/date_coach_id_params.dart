class DateCoachIdParams {
  String date;
  String coachId;

  DateCoachIdParams({required this.date, required this.coachId});

  Map<String, dynamic> toJson() => {
        "date": date,
        "coach_id": coachId,
      };
}
