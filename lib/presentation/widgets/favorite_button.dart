import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  const FavoriteButton({required this.isFavorite, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.58.w,
      height: 28.58.h,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: ColorManager.white),
      child: Icon(
        Icons.favorite,
        color: isFavorite ? ColorManager.primary : ColorManager.iconGrey,
      ),
    );
  }
}
