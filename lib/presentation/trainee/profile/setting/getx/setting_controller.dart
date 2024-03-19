import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../app/storage/app_prefs.dart';
import '../../../../../data/profile/profile_repo/profile_repository.dart';
import '../../../../widgets/toasts_messages.dart';

class SettingController extends GetxController {
  BaseProfileRepository baseProfileRepository = instance();

  RxBool pushNotification = true.obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  notification(bool notification) async {
    isLoading = true;
    (await baseProfileRepository.turnNotification(notification)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) => {pushNotification.value = !pushNotification.value});
    isLoading = false;
  }

  RxString isNotification = "".obs;

  @override
  void onInit() {
    isNotification.value = instance<AppPreferences>().getUserEntity().isNotEmpty
        ? instance<AppPreferences>().getUserEntity()[2]
        : "";
    pushNotification.value = (isNotification.value == "1");
    super.onInit();
  }
}
