import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class CustomBackGroundCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Function? onTap;
  final Function? onDoubleTap;
  final Color? backGroundColor;
  final Widget child;

  const CustomBackGroundCard(
      {Key? key,
      this.height,
      this.width,
      this.onTap,
      required this.child,
      this.backGroundColor, this.onDoubleTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: backGroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          highlightColor: Colors.white70,
          hoverColor: ColorManager.white24.withOpacity(0.15),
          onTap: onTap != null ? () => onTap!() : null,
          onDoubleTap: onDoubleTap != null ? () => onDoubleTap!() : null,
          child: SizedBox(
            width: width,
            height: height,
            child: child,
          ),
        ),
      ),
    );
  }
}
