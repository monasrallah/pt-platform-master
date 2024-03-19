import 'package:intl/intl.dart';

bool checkEmailValidity(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool checkPasswordValidity(String password) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  if (password.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(password)) {
      return false;
    } else {
      return true;
    }
  }
}

getTime(startTime, endTime) {
  bool result = false;
  int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
  int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;

  if (endTimeInt < startTimeInt) {
    result = false;
  } else {
    result = true;
  }
  return result;
}

bool isGreaterThanQuarterHour(String time, String date) {
  String input = "$date $time"; // "2024-01-13 09:30:00"
  DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
  // DateTime output = format.parse(input);
  DateTime output = format.parseStrict(input);

  DateTime now = DateTime.now();

// This condition will return false if now is within 15 minutes of output, and true otherwise
  now.isAfter(output.add(const Duration(minutes: 15))) ||
      now.isBefore(output.subtract(const Duration(minutes: 15)));

  return now.isAfter(output.add(const Duration(minutes: 15))) ||
      now.isBefore(output.subtract(const Duration(minutes: 15)));
}

// bool isArabic() {
//   return Get.find<AppController>().lang == LanguageType.ar.name;
// }
