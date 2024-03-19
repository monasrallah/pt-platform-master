import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/strings_manager.dart';

class TraineeCard extends StatelessWidget {
  const TraineeCard(
      {required this.title,
      required this.image,
      required this.start,
      required this.end,
      required this.colorStar,
      // required this.selected,
      Key? key})
      : super(key: key);
  final String image;
  final String title;
  final String start;
  final String end;
  final Color colorStar;

  // final RxBool selected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              10.verticalSpace,
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  // maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${AppStrings.start.tr} :$start",
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${AppStrings.end.tr} :$end",
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              Icons.star,
              color: colorStar,
            ),
          ),
        ),
      ],
    );
  }
}
