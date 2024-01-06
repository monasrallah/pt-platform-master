import '../../../data/coach_app/models/calender_model.dart';

class CalenderCoachEntity {
  int id;
  DateTime date;
  String time;
  bool isAutoAccept;
  String? userName;
  Status status;

  CalenderCoachEntity({
    required this.id,
    required this.date,
    required this.time,
    required this.isAutoAccept,
    required this.userName,
    required this.status,
  });
}
