import 'personal_training_model.dart';

class ShopModel {
  List<PersonalTrainingModel> subscription;
  List<PersonalTrainingModel> personalTraining;
  List<PersonalTrainingModel> premium;

  ShopModel({
    required this.subscription,
    required this.personalTraining,
    required this.premium,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        subscription: List<PersonalTrainingModel>.from(
            json["subscription"].map((x) => PersonalTrainingModel.fromJson(x))),
        personalTraining: List<PersonalTrainingModel>.from(
            json["personal_training"]
                .map((x) => PersonalTrainingModel.fromJson(x))),
        premium: List<PersonalTrainingModel>.from(
            json["premium"].map((x) => PersonalTrainingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscription": List<dynamic>.from(subscription.map((x) => x.toJson())),
        "personal_training":
            List<dynamic>.from(personalTraining.map((x) => x.toJson())),
        "premium": List<dynamic>.from(premium.map((x) => x.toJson())),
      };
}

class PersonalTrainingModel {
  int id;
  String name;
  String description;
  String price;
  PriceObjectModel priceObject;
  int date;
  Style style;
  bool isFree;
  String? purchaseAppleId;
  String? purchaseAndroidId;
  dynamic userPackage;
  PermissionsModel? permissions;

  PersonalTrainingModel({
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

  factory PersonalTrainingModel.fromJson(Map<String, dynamic> json) =>
      PersonalTrainingModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        priceObject: PriceObjectModel.fromJson(json["price_object"]),
        date: json["date"],
        style: styleValues.map[json["style"]]!,
        isFree: json["is_free"],
        purchaseAppleId: json["purchase_apple_id"],
        purchaseAndroidId: json["purchase_android_id"],
        userPackage: json["user_package"],
        permissions: json["permissions"] != null
            ? PermissionsModel.fromJson(json["permissions"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "price_object": priceObject.toJson(),
        "date": date,
        "style": styleValues.reverse[style],
        "is_free": isFree,
        "purchase_apple_id": purchaseAppleId,
        "purchase_android_id": purchaseAndroidId,
        "user_package": userPackage,
        "permissions": permissions?.toJson(),
      };
}

class PermissionsModel {
  int callVideo;
  bool workoutSchedule;
  bool foodPlan;

  PermissionsModel({
    required this.callVideo,
    required this.workoutSchedule,
    required this.foodPlan,
  });

  factory PermissionsModel.fromJson(Map<String, dynamic> json) =>
      PermissionsModel(
        callVideo: json["call_video"],
        workoutSchedule: json["workout_schedule"],
        foodPlan: json["food_plan"],
      );

  Map<String, dynamic> toJson() => {
        "call_video": callVideo,
        "workout_schedule": workoutSchedule,
        "food_plan": foodPlan,
      };
}

class PriceObjectModel {
  String amount;
  String formatted;
  Currency currency;

  PriceObjectModel({
    required this.amount,
    required this.formatted,
    required this.currency,
  });

  factory PriceObjectModel.fromJson(Map<String, dynamic> json) =>
      PriceObjectModel(
        amount: json["amount"],
        formatted: json["formatted"],
        currency: currencyValues.map[json["currency"]]!,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "formatted": formatted,
        "currency": currencyValues.reverse[currency],
      };
}

class DiscountModel {
  String discount;
  String old_price;
  num price;

  DiscountModel({
    required this.discount,
    required this.old_price,
    required this.price,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        discount: json["discount"],
        old_price: json["old_price"],
        price: json["price"],
      );
}

enum Currency { USD }

final currencyValues = EnumValues({"usd": Currency.USD});

enum Style { STYLE_BRONZE, STYLE_GOLD, STYLE_SILVER, STYLE_FREE }

final styleValues = EnumValues({
  "style_bronze": Style.STYLE_BRONZE,
  "style_gold": Style.STYLE_GOLD,
  "style_silver": Style.STYLE_SILVER,
  "style_free": Style.STYLE_FREE,
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

class TipsModel {
  List<DataModel> tips;

  TipsModel({required this.tips});

  factory TipsModel.fromJson(Map<String, dynamic> json) {
    List<DataModel> all = [];
    for (var element in (json['tips'] as List<dynamic>)) {
      all.add(DataModel.fromJson(element as Map<String, dynamic>));
    }
    return TipsModel(tips: all);
  }
}

class StripeModel {
  String status;
  String url;

  StripeModel({
    required this.status,
    required this.url,
  });

  factory StripeModel.fromJson(Map<String, dynamic> json) => StripeModel(
    status: json["status"],
    url: json["url"],
  );
}
