class GetAppleIapIdParams {
  int id;
  String coachId;
  String? promotionCode;
  String paymentMethod;

  GetAppleIapIdParams({
    required this.id,
    required this.coachId,
    required this.paymentMethod,
    this.promotionCode,
  });

  Map<String, dynamic> toJson() {
    if (promotionCode != null) {
      return {
        "id": id,
        "payment_method": paymentMethod,
        "code": promotionCode,
        "coach_id": coachId,
      };
    } else {
      return {
        "id": id,
        "payment_method": paymentMethod,
        "coach_id": coachId,
      };
    }
  }
}
