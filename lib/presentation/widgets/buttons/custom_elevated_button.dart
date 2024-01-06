import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/design_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String title;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Function? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsDirectional? padding;
  final BorderRadius? borderRadius;
  final double? elevation;

  const CustomElevatedButton(
      {required this.title,
      Key? key,
      this.height,
      this.width,
      this.maxLines,
      this.textStyle,
      this.textAlign,
      this.padding,
      this.elevation,
      this.borderRadius,
      this.backgroundColor,
      this.foregroundColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 1.sw,
      height: height ?? 60.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: elevation ?? 6,
            padding: padding ?? EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? smallBorderRadius),
          ),
          onPressed: onTap != null
              ? () {
                  onTap!();
                }
              : null,
          child: Text(
            title,
            textAlign: textAlign ?? TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            style: textStyle ??
                Get.theme.textTheme.bodyLarge?.copyWith(fontSize: 23.sp),
          )),
    );
  }
}
