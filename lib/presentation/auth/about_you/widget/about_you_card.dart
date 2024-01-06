import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';

class AboutYouCard extends StatelessWidget {
   AboutYouCard({required this.title, required this.selected, Key? key})
      : super(key: key);
  final String title;
   bool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 220.h,
          padding: EdgeInsetsDirectional.only(end: 20.w, start: 15.w),
          decoration: BoxDecoration(
            color: ColorManager.darkGrey,
            border: Border.all(color: ColorManager.primary, width: 1.5.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              title,
              style: Get.textTheme.displayLarge!.copyWith(fontSize: 35.sp),
            ),
          ),
        ),
        PositionedDirectional(
          end: 15,
          top: 15,
          child: Container(
            height: 35.h,
            width: 35.h,
            decoration: BoxDecoration(
                color: ColorManager.black,
                border: Border.all(color: ColorManager.primary),
                borderRadius: BorderRadius.circular(100.r)),
            child: selected
                ? Icon(
                    Icons.check,
                    color: ColorManager.primary,
                  )
                : null,
          ),
        )
      ],
    );
  }
}
