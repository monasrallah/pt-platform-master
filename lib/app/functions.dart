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

// bool isArabic() {
//   return Get.find<AppController>().lang == LanguageType.ar.name;
// }
