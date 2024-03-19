class GetAppleIapIdModel {
  String productAppleId;

  GetAppleIapIdModel({required this.productAppleId});

  factory GetAppleIapIdModel.fromJson(Map<String, dynamic> json) =>
      GetAppleIapIdModel(
        productAppleId: json["product_apple_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_apple_id": productAppleId,
      };
}
