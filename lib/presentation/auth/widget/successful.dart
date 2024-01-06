import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';

class SuccessfulView extends StatelessWidget {
  const SuccessfulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              width: 1.sw,
              height: 1.sh,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.grey.shade800.withOpacity(0.95), BlendMode.modulate),
                child: Image.asset(
                  ImageAssets.manBackground,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Thank you!",
                  style:
                      Get.textTheme.displayLarge!.copyWith(fontSize: 40.sp),
                ),
                Text(
                  "Our team will get back to you soon!",
                  style:
                      Get.textTheme.displayLarge!.copyWith(fontSize: 30.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
