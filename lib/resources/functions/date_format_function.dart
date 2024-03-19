String dateFormat({DateTime? date}) {
  String result = "";
  if (date != null) {
    date = date.add(const Duration(hours: 3));
    result =
        "${date.year}/${date.month}/${date.day}  "; /*,${timeFormat(date)}*/
  }
  return result;
}

String timeFormat({DateTime? dateTime, bool isArabic = false}) {
  String time = "";
  if (dateTime != null) {
    dateTime = dateTime.add(const Duration(hours: 3));
    if (dateTime.hour > 12) {
      time = isArabic
          ? "${dateTime.hour - 12}:${minutesFormat(dateTime)} م "
          : "${dateTime.hour - 12}:${minutesFormat(dateTime)} PM ";
    } else {
      if (dateTime.hour == 12) {
        time = isArabic
            ? "${dateTime.hour}:${minutesFormat(dateTime)} م "
            : "${dateTime.hour}:${minutesFormat(dateTime)} PM ";
      } else if (dateTime.hour == 0) {
        time = isArabic
            ? "${dateTime.hour + 12}:${minutesFormat(dateTime)} ص "
            : "${dateTime.hour + 12}:${minutesFormat(dateTime)} AM ";
      } else if (dateTime.hour < 12) {
        time = isArabic
            ? "${dateTime.hour}:${minutesFormat(dateTime)} ص "
            : "${dateTime.hour}:${minutesFormat(dateTime)} AM ";
      }
    }
  }

  return time;
}

String minutesFormat(DateTime dateTime) {
  String minutes = "";
  if (dateTime.minute >= 0 && dateTime.minute <= 9) {
    minutes = "0${dateTime.minute}";
  } else {
    minutes = "${dateTime.minute}";
  }
  return minutes;
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final twoDigitsHours = twoDigits(duration.inHours);
  final twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
  final twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
  return [
    if (duration.inHours > 0) twoDigitsHours,
    twoDigitsMinutes,
    twoDigitsSeconds
  ].join(":");
}
