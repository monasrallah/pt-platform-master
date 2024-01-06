import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoritesCard extends StatelessWidget {
  const FavoritesCard({required this.title, required this.image, Key? key})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
            width: 1.sw,
            height: 150.h,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
        12.verticalSpace,
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }
}
