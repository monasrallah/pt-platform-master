import '../../coach/models/shop_model.dart';

class AllUsersModel {
  List<UserModel> users;

  AllUsersModel({required this.users});

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    List<UserModel> all = [];
    for (var element in (json['users'] as List<dynamic>)) {
      all.add(UserModel.fromJson(element as Map<String, dynamic>));
    }
    return AllUsersModel(users: all);
  }
}

class UserModel {
  int id;
  String? avatar;
  String name;
  String startDate;
  String endDate;
  String packageName;
  String type;
  Style style;

  UserModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.packageName,
    required this.type,
    required this.style,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        packageName: json["package_name"],
        type: json["type"],
        style: styleValues.map[json["package_style"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "start_date": startDate,
        "end_date": endDate,
        "package_name": packageName,
        "type": type,
      };
}
