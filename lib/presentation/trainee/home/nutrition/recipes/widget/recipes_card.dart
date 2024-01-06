import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecipesCard extends StatelessWidget {
  const RecipesCard({required this.title, required this.image, Key? key})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              height: 300.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.r),
                child: Image.network(
                  image,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
            flex: 1,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
            ),
          ),
        ],
      ),
    );
  }
}
