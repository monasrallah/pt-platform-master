import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageCardHorizon extends StatelessWidget {
  const ImageCardHorizon({
    required this.image,
    required this.title,
    this.des,
    this.titleStyle,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String image;
  final String title;
  final String? des;
  final TextStyle? titleStyle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () => onTap(),
        child: SizedBox(
          height: 100.h,
          child: Row(
            children: [
              SizedBox(
                width: 150.w,
                height: 100.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              12.horizontalSpace,
              Column(
                mainAxisAlignment: (des != null)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.55.sw,
                    child: Text(
                      title,
                      style: titleStyle ??
                          Get.textTheme.bodySmall!.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  if (des != null)
                    SizedBox(
                      width: 0.5.sw,
                      child: Text(
                        des!,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
