class ResetParams {
  String password;
  String confirmPassword;
  String token;

  ResetParams(
      {required this.password,
      required this.confirmPassword,
      required this.token});

  Map<String, dynamic> toJson() => {
        "password_confirmation": confirmPassword,
        "password": password,
        "token": token,
      };
}
