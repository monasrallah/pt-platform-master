class TraineeModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String status;
  dynamic avatar;
  String? role;
  int? isSendNotification;

  // List<dynamic> categories;

  TraineeModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.avatar,
    this.role,
    this.isSendNotification,
    // required this.categories,
  });

  factory TraineeModel.fromJson(Map<String, dynamic> json) {
    if (json['role'] == 'coach') {
      throw Exception('you are trying to login with a different account type , back and change the account type');
    }

    return TraineeModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      status: json["status"],
      avatar: json["avatar"],
      role: json["role"],
      isSendNotification: json["is_send_notification"],
      // categories: List<dynamic>.from(json["categories"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "status": status,
        "avatar": avatar,
        "role": role,
        "is_send_notification": isSendNotification,
        // "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}
