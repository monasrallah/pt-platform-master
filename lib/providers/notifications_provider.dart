import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pt_platform/presentation/trainee/coach/Personalized/personal_training/personal_training_view.dart';
import 'package:pt_platform/presentation/trainee/coach/Personalized/video_chat/video_chat_view.dart';
import 'package:pt_platform/presentation/trainee/coach/shop/shop_view.dart';
import 'package:pt_platform/presentation/trainee/home/news/news_view.dart';
import 'package:pt_platform/presentation/trainee/home/trainer/trainer_view.dart';

class NotificationsProvider extends GetxController {
  Future<bool> init(BuildContext context) async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await setUserToken(context);
    });
    return true;
  }

  ///----------------------///
  ///----Set User Token----///
  ///----------------------///
  String userNotificationToken = '';
  Future setUserToken(BuildContext context) async {
    await OneSignal.shared.getDeviceState().then((value) {
      log('value value');
      log(value.toString());
      userNotificationToken = value!.userId.toString();
      log(userNotificationToken.toString());
    });

    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result) async {
        Map<String, dynamic>? pageType = result.notification.additionalData;

        // ignore: prefer_interpolation_to_compose_strings
        log('result: ' + pageType!['type']);

        try {
          if (pageType['type'] == 'news_feed') {
            Get.to(const NewsView());
          } else if (pageType['type'] == 'expired_package') {
            Get.to(const ShopView());
          } else if (pageType['type'] == 'personal_training') {
            Get.to(const PersonalTrainingView());
          } else if (pageType['type'] == 'approved_video_chat') {
            Get.to(const VideoChatView());
          } else if (pageType['type'] == 'new_coach') {
            Get.to(const TrainerView());
          } else {
            // Get.to(const SplashView());
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
    
    update();
  }
}
