class AllCalendersModel {
  List<CalenderModel> calenders;

  AllCalendersModel({required this.calenders});

  factory AllCalendersModel.fromJson(Map<String, dynamic> json) {
    List<CalenderModel> all = [];
    for (var element in (json['available'] as List<dynamic>)) {
      all.add(CalenderModel.fromJson(element as Map<String, dynamic>));
    }
    return AllCalendersModel(calenders: all);
  }
}

class CalenderModel {
  int id;
  String time;
  bool isAutoAccept;
  bool isAvailable;

  CalenderModel({
    required this.id,
    required this.time,
    required this.isAutoAccept,
    required this.isAvailable,
  });

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
        id: json["id"],
        time: json["time"],
        isAutoAccept: json["is_auto_accept"],
        isAvailable: json["is_available"],
      );
}
