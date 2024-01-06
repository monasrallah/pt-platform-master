import 'package:get/get.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';

class LanguageController extends GetxController {
  String lang = "en";

  final RxBool arabic = false.obs;
  final RxBool english = true.obs;

  changeLanguage({required bool isEnglish}) {
    if (isEnglish) {
      english.value = true;
      arabic.value = false;
    } else {
      english.value = false;
      arabic.value = true;
    }
  }

  @override
  onInit() async {
    lang = instance<AppPreferences>().getAppLanguage();
    arabic.value = lang == "ar";
    english.value = lang != "ar";
    super.onInit();
  }

  // bool get arabic => _arabic.value;
  //
  // set arabic(bool value) {
  //   _arabic.value = value;
  // }
  //
  // bool get english => _english.value;
  //
  // set english(bool value) {
  //   _english.value = value;
  // }
}
