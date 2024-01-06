class OtpParams {
  String token;
  String code;

  OtpParams({required this.token, required this.code});

  Map<String, dynamic> toJson() => {
        "token": token,
        "code": code,
      };
}