import '../../../data/coach/models/shop_model.dart';

class UserEntity {
  int id;
  String? avatar;
  String name;
  String startDate;
  String endDate;
  String packageName;
  String type;
  Style style;

  UserEntity({
    required this.id,
    required this.avatar,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.packageName,
    required this.type,
    required this.style,
  });

}
