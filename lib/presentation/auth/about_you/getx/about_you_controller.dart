import 'package:get/get.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';

class AboutYouController extends GetxController {
  RxBool selectedTrainee = true.obs;

  tapTrainee() {
    if (!selectedTrainee.value) {
      selectedTrainee.value = !selectedTrainee.value;
      instance<AppPreferences>().setLoginUser(true);
    }
  }

  tapCoach() {
    if (selectedTrainee.value) {
      selectedTrainee.value = !selectedTrainee.value;
      instance<AppPreferences>().setLoginUser(false);
    }
  }
}
