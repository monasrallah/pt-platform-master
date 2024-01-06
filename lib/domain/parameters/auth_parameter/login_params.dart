import 'device_params.dart';

class LoginParams {
  String email;
  String password;
  DeviceParams device;

  LoginParams(
      {required this.email, required this.password, required this.device});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "device": device.toJson(),
      };
}
