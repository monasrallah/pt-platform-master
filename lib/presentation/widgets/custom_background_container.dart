import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CustomBackGroundContainer extends StatelessWidget {
  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? backGroundColor;

  const CustomBackGroundContainer(
      {Key? key,
      required this.child,
      this.horizontalPadding,
      this.verticalPadding,
      this.backGroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 2.w, vertical: (verticalPadding ?? 0)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          color: backGroundColor ?? theme.primaryColor.withOpacity(0.1)),
      child: child,
    );
  }
}
