class MessageEntity {
  String message;
  int receiver_id;
  int sender_id;
  var time;

  factory MessageEntity.fromJson(Map<dynamic, dynamic> json) => MessageEntity(
        message: json["message"],
        receiver_id: json["receiver_id"],
        sender_id: json["sender_id"],
        time: json["time"],
      );

  factory MessageEntity.init() => MessageEntity(
        message: "",
        receiver_id: 0,
        sender_id: 0,
        time: 0,
      );

  MessageEntity(
      {required this.message,
      required this.receiver_id,
      required this.sender_id,
      required this.time});
}
