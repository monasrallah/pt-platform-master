class TokenVerificationModel {
  String token;

  TokenVerificationModel({
    required this.token,
  });

  factory TokenVerificationModel.fromJson(Map<String, dynamic> json) =>
      TokenVerificationModel(
        token: json["token"],
      );
}
