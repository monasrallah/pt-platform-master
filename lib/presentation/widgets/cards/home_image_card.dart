import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeImageCard extends StatelessWidget {
  const HomeImageCard({
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
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 110.h,
            width: 110.h,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
