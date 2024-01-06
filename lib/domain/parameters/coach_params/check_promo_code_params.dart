class CheckPromoCodeParams {
  int package_id;
  String code;

  CheckPromoCodeParams({required this.package_id, required this.code});

  Map<String, dynamic> toJson() => {
        "package_id": package_id,
        "code": code,
      };
}
