import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/providers/notifications_provider.dart';

import '../../resources/assets_manager.dart';
import 'getx/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<NotificationsProvider>().init(context),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // alignment: Alignment.center,
                    height: 250.h,
                    width: 270.w,
                    child: Image.asset(
                      IconsAssets.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
