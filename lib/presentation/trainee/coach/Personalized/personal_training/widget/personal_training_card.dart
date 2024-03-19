import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalTrainingCard extends StatelessWidget {
  const PersonalTrainingCard(
      {required this.title, required this.image, Key? key})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        children: [
          SizedBox(
            height: 250.h,
            width: 0.4.sw,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          10.verticalSpace,
          Text(
            title,
            // maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}
