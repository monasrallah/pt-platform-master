class ProfileModel {
  int id;
  String firstName;
  String lastName;
  String email;
  int? phoneNumber;
  String? avatar;
  String? description;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.avatar,
    required this.description,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        avatar: json["avatar"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "avatar": avatar,
        "description": description,
      };
}
