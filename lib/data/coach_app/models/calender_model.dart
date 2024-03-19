class AllCalendersCoachModel {
  List<CalenderCoachModel> calenders;

  AllCalendersCoachModel({required this.calenders});

  factory AllCalendersCoachModel.fromJson(Map<String, dynamic> json) {
    List<CalenderCoachModel> all = [];
    for (var element in (json['calendar'] as List<dynamic>)) {
      all.add(CalenderCoachModel.fromJson(element as Map<String, dynamic>));
    }
    return AllCalendersCoachModel(calenders: all);
  }
}

class CalenderCoachModel {
  int id;
  DateTime date;
  String time;
  bool isAutoAccept;
  String? userName;
  Status status;

  CalenderCoachModel({
    required this.id,
    required this.date,
    required this.time,
    required this.isAutoAccept,
    required this.userName,
    required this.status,
  });

  factory CalenderCoachModel.fromJson(Map<String, dynamic> json) =>
      CalenderCoachModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        isAutoAccept: json["is_auto_accept"],
        userName: json["user_name"],
        status: statusValues.map[json["status"]]!,
      );
}

enum Status { ACCEPT, PENDING, WAITING }

final statusValues = EnumValues({
  "accept": Status.ACCEPT,
  "pending": Status.PENDING,
  "waiting": Status.WAITING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
