import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard(
      {required this.title, required this.image, this.imageLocal, Key? key})
      : super(key: key);
  final String image;
  final String? imageLocal;
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
              child: imageLocal != null
                  ? Image.asset(
                      imageLocal!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
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
