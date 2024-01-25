import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationsProvider extends GetxController {
  Future<bool> init(BuildContext context) async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Get.find<NotificationsProvider>().setUserToken(context);
    });
    return true;
  }

  ///-----------------------------------///
  ///----Set User Notification Token----///
  ///-----------------------------------///
  String userNotificationToken = '';
  Future<String> setUserToken(BuildContext context) async {
    userNotificationToken = OneSignal.User.pushSubscription.id.toString();
    log('User Notification Token $userNotificationToken');

    update();
    return userNotificationToken;
  }
}
