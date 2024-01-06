class ChangePasswordParams {
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordParams(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmNewPassword});

  Map<String, dynamic> toJson() => {
        "current_password": oldPassword,
        "password": newPassword,
        "password_confirmation": confirmNewPassword,
      };
}
