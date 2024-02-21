import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssignedCoachCard extends StatelessWidget {
  const AssignedCoachCard({required this.title, required this.image, Key? key})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 1.sw,
          height: 250.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
