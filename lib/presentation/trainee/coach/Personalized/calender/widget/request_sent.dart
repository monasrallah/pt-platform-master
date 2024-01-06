import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/presentation/trainee/coach/Personalized/calender/getx/calender_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

class RequestSentPage extends StatelessWidget {
  const RequestSentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalenderController>();
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              size: 300,
              color: ColorManager.primary,
            ),
            Text(
              AppStrings.requestSent.tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge,
            ),
            SizedBox(
              width: 0.7.sw,
              child: Text(
                AppStrings.yourRequestAwaiting.tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodySmall,
              ),
            ),
            40.verticalSpace,
            CustomElevatedButton(
              title: AppStrings.returnToMainScreen.tr,
              width: 0.85.sw,
              textStyle: Get.textTheme.bodySmall!.copyWith(fontSize: 19.sp),
              onTap: () {
                Get.find<AppController>().onItemTapped(1);
              },
            ),
            30.verticalSpace,
            CustomElevatedButton(
              title: AppStrings.addToCalender.tr,
              width: 0.85.sw,
              backgroundColor: ColorManager.grey,
              elevation: 0,
              textStyle: Get.textTheme.bodySmall!.copyWith(fontSize: 19.sp),
              onTap: () {
                controller.addToDeviceCalendar();
              },
            ),
          ],
        ),
      ),
    );
  }
}
