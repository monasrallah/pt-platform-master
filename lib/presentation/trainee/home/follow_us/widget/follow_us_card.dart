import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FollowUsCard extends StatelessWidget {
  const FollowUsCard({required this.title, required this.iconImage, Key? key})
      : super(key: key);
  final String iconImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconImage),
            12.horizontalSpace,
            Text(
              title,
              style: Get.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
