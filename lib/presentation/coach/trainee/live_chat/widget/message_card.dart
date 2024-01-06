import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/color_manager.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({required this.color, Key? key, required this.message}) : super(key: key);
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          end: color == ColorManager.primary ? 120.w : 0,
          start: color != ColorManager.primary ? 120.w : 0,
          bottom: 10.h),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Text(
          message,
          style: Get.textTheme.bodySmall!.copyWith(fontSize: 14.sp),
        ),
      ),
    );
  }
}
