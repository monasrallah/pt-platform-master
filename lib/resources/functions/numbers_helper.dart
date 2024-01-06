import 'package:intl/intl.dart';

class NumbersHelper {
  static getMoneyFormat(dynamic number) {
    var f = NumberFormat("###,###");
    return f.format(number);
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    if (s.isEmpty) return true;
    if (s[s.length - 1] == ".") return false;
    return double.tryParse(s) != null;
  }

  static String? correctNumber(String s) {
    if (!isNumeric(s)) return null;
    return double.parse(s).toString();
  }

  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++){
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }
}
