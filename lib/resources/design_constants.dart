import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';

OutlineInputBorder kOutlinedBorderGray = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: ColorManager.grey),
);
OutlineInputBorder kOutlinedBorderWhite = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: ColorManager.white),
);
OutlineInputBorder kOutlinedBorderBlack = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: ColorManager.black),
);
OutlineInputBorder kOutlinedBorderRed = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: ColorManager.primary),
);
UnderlineInputBorder kUnderlinedBorderRed = UnderlineInputBorder(
  borderSide: BorderSide(color: ColorManager.primary),
);
UnderlineInputBorder kUnderlinedBorderWhite = UnderlineInputBorder(
  borderSide: BorderSide(color: ColorManager.white),
);
UnderlineInputBorder kUnderlinedBorderBlack = UnderlineInputBorder(
  borderSide: BorderSide(color: ColorManager.black),
);
UnderlineInputBorder kUnderlinedBorderGrey = UnderlineInputBorder(
  borderSide: BorderSide(color: ColorManager.grey),
);
UnderlineInputBorder kUnderlinedBorderTransparent = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.transparent),
);

BoxShadow veryLowElevation = BoxShadow(
    color: ColorManager.black.withOpacity(0.04),
    offset: const Offset(0, 0),
    blurRadius: 6,
    spreadRadius: 1);
BoxShadow lowElevation = BoxShadow(
    color: ColorManager.black.withOpacity(0.16),
    offset: const Offset(0, 0),
    blurRadius: 6,
    spreadRadius: 2);
BoxShadow lowWhiteElevation = BoxShadow(
    color: ColorManager.black.withOpacity(0.16),
    offset: const Offset(0, 0),
    blurRadius: 6,
    spreadRadius: 2);

BorderRadius lowBorderRadius = BorderRadius.all(Radius.circular(8.r));
BorderRadius smallBorderRadius = BorderRadius.all(Radius.circular(12.r));
BorderRadius medBorderRadius = BorderRadius.all(Radius.circular(16.r));
BorderRadius highBorderRadius = BorderRadius.all(Radius.circular(24.r));
BorderRadius xHighBorderRadius = BorderRadius.all(Radius.circular(50.r));
BorderRadius circularBorderRadius = BorderRadius.circular(100.r);

// Map<String, Widget> templateLabelsIcons = {
//   'read': SvgPicture.asset(ImageAssets.docs),
//   'write': SvgPicture.asset(ImageAssets.docs)
// };
