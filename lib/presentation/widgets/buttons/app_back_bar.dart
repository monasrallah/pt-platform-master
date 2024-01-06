import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';

PreferredSize appBackBar(
    {required String title,
    Function? onTap,
    Color? backgroundColor,
    bool? withAction = false,
    Function? onTapAction}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      actions: withAction!
          ? [
              InkWell(
                onTap: onTapAction != null ? () => onTapAction() : null,
                child: Icon(
                  Icons.info_outline,
                  color: ColorManager.primary,
                  size: 30.w,
                ),
              ),
              20.horizontalSpace,
            ]
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onTap != null ? onTap() : Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: ColorManager.primary,
              size: 30.w,
            ),
          ),
          40.horizontalSpace,
          Text(
            title,
            style: Get.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
          ),
        ],
      ),
    ),
  );
}
