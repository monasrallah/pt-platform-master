import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_platform/resources/color_manager.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function onTap;

  const CustomCheckbox(
      {required this.isChecked, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: AnimatedContainer(
          height: 28.h,
          width: 28.h,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: Colors.black),
          ),
          child: isChecked
              ? Icon(
                  Icons.circle,
                  color: ColorManager.primary,
                  size: 20.w,
                )
              : null,
        ),
      ),
    );
  }
}
