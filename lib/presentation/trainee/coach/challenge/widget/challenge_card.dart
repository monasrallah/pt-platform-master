import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard(
      {Key? key,
      required this.imagePath,
      required this.day,
      required this.description})
      : super(key: key);
  final String imagePath;
  final String day;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.h,
          width: 1.sw,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, top: 12.h),
          child: Text(
            day,
            style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, bottom: 25.h),
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
