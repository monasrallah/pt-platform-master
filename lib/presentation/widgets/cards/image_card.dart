import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    this.isSvg = true,
    required this.image,
    required this.title,
    this.titleStyle,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final bool isSvg;
  final String image;
  final String title;
  final TextStyle? titleStyle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 90.h,
                width: 90.h,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            Positioned(
              top: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 90.h,
                  width: 90.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.5),
                        ColorManager.white
                      ], // define your own color range here
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 70.h,
                      width: 70.h,
                      margin: EdgeInsets.all(12.h),
                      padding: EdgeInsets.all(11.h),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: isSvg
                          ? SvgPicture.asset(
                              image,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                  ColorManager.purple, BlendMode.srcIn),
                            )
                          : Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle ??
                Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
          ),
        ),
      ],
    );
  }
}
