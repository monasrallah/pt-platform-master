import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({required this.title, required this.iconImage, Key? key})
      : super(key: key);
  final String iconImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          // color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                iconImage,
                fit: BoxFit.cover,
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                12.horizontalSpace,
                SizedBox(
                  height: 50.h,
                  width: 0.75.sw,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
