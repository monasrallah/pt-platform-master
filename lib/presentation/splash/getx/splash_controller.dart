import 'dart:async';

import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../../app/dependency_injection.dart';
import '../../../app/storage/app_prefs.dart';
import '../../../resources/routes_manager.dart';

class SplashController extends GetxController {
  String token = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    token = instance<AppPreferences>().getAccessToken();
    await Future.delayed(const Duration(seconds: 3), () {
      if (token.isEmpty) {
        Get.offAllNamed(Routes.aboutYouRoute);
      } else {
        instance<AppPreferences>().getLoginUser()!
            ? Get.find<AppController>().onItemTapped(0)
            : Get.offAllNamed(Routes.coachHomeRoute);
      }
    });
  }
}
