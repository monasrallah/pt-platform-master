import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleFieldWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final IconData? icon;

  const TitleFieldWidget(
      {required this.text, Key? key, this.textStyle, this.textAlign, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Text(
              text,
              style: textStyle,
              textAlign: textAlign ?? TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
