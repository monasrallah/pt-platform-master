import 'device_params.dart';

class RegisterTraineeParams {
  String token;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;
  DeviceParams device;

  RegisterTraineeParams({
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.device,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "password_confirmation": confirmPassword,
        "device": device.toJson(),
      };
}

class RegisterCoachParams {
  String token;
  String firstName;
  String lastName;
  String mobile;
  List<int> categories;
  String password;
  String confirmPassword;
  String socialMediaLink;
  String potentialTrainees;
  DeviceParams device;

  RegisterCoachParams({
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.categories,
    required this.password,
    required this.confirmPassword,
    required this.socialMediaLink,
    required this.potentialTrainees,
    required this.device,
  });

  Map<String, dynamic> toJson() => {
        "token": token,
        "full_name": firstName,
        "nick_name": lastName,
        "phone_number": mobile,
        "categories_ids": categories,
        "password": password,
        "password_confirmation": confirmPassword,
        "link_social_media": socialMediaLink,
        "potential_clients": potentialTrainees,
        "device": device.toJson(),
      };
}
