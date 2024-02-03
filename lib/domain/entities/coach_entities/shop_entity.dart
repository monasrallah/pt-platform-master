import '../../../data/coach/models/shop_model.dart';

class ShopEntity {
  List<PersonalTrainingEntity> subscription;
  List<PersonalTrainingEntity> personalTraining;
  List<PersonalTrainingEntity> premium;

  ShopEntity({
    required this.subscription,
    required this.personalTraining,
    required this.premium,
  });
}

class PersonalTrainingEntity {
  int id;
  String name;
  String description;
  String price;
  PriceObjectEntity priceObject;
  int date;
  Style style;
  bool isFree;
  String? purchaseAppleId;
  String? purchaseAndroidId;
  dynamic userPackage;
  PermissionsEntity? permissions;

  PersonalTrainingEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.priceObject,
    required this.date,
    required this.style,
    required this.isFree,
    required this.purchaseAppleId,
    required this.purchaseAndroidId,
    required this.userPackage,
     this.permissions,
  });
}

class PermissionsEntity {
  int callVideo;
  bool workoutSchedule;
  bool foodPlan;

  PermissionsEntity({
    required this.callVideo,
    required this.workoutSchedule,
    required this.foodPlan,
  });
}

class PriceObjectEntity {
  String amount;
  String formatted;
  String currency;

  PriceObjectEntity({
    required this.amount,
    required this.formatted,
    required this.currency,
  });
}

class DiscountEntity {
  String discount;
  String old_price;
  num price;

  DiscountEntity({
    required this.discount,
    required this.old_price,
    required this.price,
  });
}

class StripeEntity {
  String status;
  String url;

  StripeEntity({
    required this.status,
    required this.url,
  });
}

// enum Currency { USD }
//
// final currencyValues = EnumValues({"usd": Currency.USD});
//
// enum Style { STYLE_BRONZE, STYLE_GOLD, STYLE_SILVER }
//
// final styleValues = EnumValues({
//   "style_bronze": Style.STYLE_BRONZE,
//   "style_gold": Style.STYLE_GOLD,
//   "style_silver": Style.STYLE_SILVER
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
