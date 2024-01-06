class PackagePaymentParams {
  int id;
  String paymentMethod;
  String code;
  String? coachId;

  PackagePaymentParams(
      {required this.id,
      required this.paymentMethod,
      required this.code,
      this.coachId});

  Map<String, dynamic> toJson() => {
        "id": id,
        "payment_method": paymentMethod,
        "code": code,
        "coach_id": coachId,
      };
}

class TipsPaymentParams {
  int id;
  String paymentMethod;
  String? coachId;

  TipsPaymentParams(
      {required this.id,
      required this.paymentMethod,
      this.coachId});

  Map<String, dynamic> toJson() => {
        "tip_id": id,
        "payment_method": paymentMethod,
        "coach_id": coachId,
      };
}
