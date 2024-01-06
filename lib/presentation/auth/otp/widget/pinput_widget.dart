import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../getx/otp_controller.dart';

class PinPutWidget extends GetView<OtpController> {
  const PinPutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Pinput(
              controller: controller.codeController,
              crossAxisAlignment: CrossAxisAlignment.center,
              keyboardType: TextInputType.none,
              length: 4,
              onCompleted: (String? value) {
                // controller.checkOtp();
                Get.toNamed(Routes.resetPasswordRoute);
              },
              preFilledWidget: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: ColorManager.grey.withOpacity(0.2),
                    shape: BoxShape.circle),
              ),
              // separator: const SizedBox(
              //   width: 0,
              // ),
              // validator: (String? value) {
              //   if (valid(value!)) {
              //     return null;
              //   } else {
              //     return AppStrings.validFiled.tr;
              //   }
              // },
              defaultPinTheme: PinTheme(
                width: 40.w,
                height: 40.h,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: const EdgeInsets.all(0),
              ),
              focusedPinTheme: PinTheme(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    shape: BoxShape.circle),
                textStyle: Theme.of(context).textTheme.titleLarge!,
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: const EdgeInsets.all(0),
              ),
              submittedPinTheme: PinTheme(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    shape: BoxShape.circle),
                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18.sp),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                padding: const EdgeInsets.all(0),
              ),
            ),
            // SizedBox(
            //   height: 4.h,
            //   child: ListView.separated(
            //     padding: EdgeInsets.symmetric(horizontal: 25.w),
            //     separatorBuilder: (context, index) => SizedBox(
            //       width: 7.w,
            //     ),
            //     itemBuilder: (context, index) => Container(
            //       width: 60.w,
            //       height: 3.h,
            //       decoration: BoxDecoration(
            //         color: ColorManager.black,
            //       ),
            //     ),
            //     itemCount: 4,
            //     scrollDirection: Axis.horizontal,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
