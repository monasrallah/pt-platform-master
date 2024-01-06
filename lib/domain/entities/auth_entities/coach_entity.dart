import 'category_entity.dart';

class CoachEntity {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? status;
  String? avatar;
  String? phoneNumber;
  String? description;
  String? linkSocialMedia;
  int? potentialClients;
  bool? isSubscription;
  String? role;
  List<CategoryEntity>? categories;
  List<TipEntity>? tips;

  CoachEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.status,
    this.avatar,
    this.phoneNumber,
    this.description,
    this.isSubscription,
    this.linkSocialMedia,
    this.potentialClients,
    this.role,
    this.categories,
    this.tips,
  });

  factory CoachEntity.init() {
    return CoachEntity();
  }
}


class TipEntity {
  int id;
  int value;

  TipEntity({
    required this.id,
    required this.value,
  });

  factory TipEntity.fromJson(Map<String, dynamic> json) => TipEntity(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}

// class CategoryEntity {
//   int id;
//   String name;
//
//   CategoryEntity({
//     required this.id,
//     required this.name,
//   });
//
//   factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
//     id: json["id"],
//     name: json["name"],
//   );
// }
