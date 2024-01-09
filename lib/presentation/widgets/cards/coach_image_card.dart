import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CoachImageCard extends StatelessWidget {
  const CoachImageCard({
    required this.image,
    required this.title,
    this.titleStyle,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String image;
  final String title;
  final TextStyle? titleStyle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 100.h,
            width: 110.h,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        12.verticalSpace,
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                Get.textTheme.bodySmall!.copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
