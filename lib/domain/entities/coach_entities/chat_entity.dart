
class ChatEntity {
  int id;
  int userId;
  String username;
  String time;
  int isAutoAccept;
  String date;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  CoachTimeReservationEntity coachTimeReservation;

  ChatEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.time,
    required this.isAutoAccept,
    required this.date,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.coachTimeReservation,
  });
}

class CoachTimeReservationEntity {
  int id;
  int coachTimeId;
  int userId;
  String status;
  ZoomEntity zoom;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  CoachTimeReservationEntity({
    required this.id,
    required this.coachTimeId,
    required this.userId,
    required this.status,
    required this.zoom,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ZoomEntity {
  bool success;
  ZoomDataEntity data;

  ZoomEntity({
    required this.success,
    required this.data,
  });
}

class ZoomDataEntity {
  String uuid;
  int id;
  String hostId;
  String hostEmail;
  String topic;
  int type;
  String status;
  DateTime startTime;
  int duration;
  String timezone;
  DateTime createdAt;
  String startUrl;
  String joinUrl;
  String password;
  String h323Password;
  String pstnPassword;
  String encryptedPassword;

  // Settings settings;
  bool preSchedule;

  ZoomDataEntity({
    required this.uuid,
    required this.id,
    required this.hostId,
    required this.hostEmail,
    required this.topic,
    required this.type,
    required this.status,
    required this.startTime,
    required this.duration,
    required this.timezone,
    required this.createdAt,
    required this.startUrl,
    required this.joinUrl,
    required this.password,
    required this.h323Password,
    required this.pstnPassword,
    required this.encryptedPassword,
    // required this.settings,
    required this.preSchedule,
  });
}
