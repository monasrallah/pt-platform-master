import 'package:flutter/material.dart';

import '../../resources/value_manager.dart';
import 'dart:math' as math;

class CustomBackIcon extends StatelessWidget {
  final Function onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? backGroundColor;
  final double? rightPadding;
  final double? leftPadding;

  const CustomBackIcon(
      {required this.onPressed,
      this.icon,
      Key? key,
      this.rightPadding,
      this.leftPadding,
      this.iconColor,
      this.backGroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 3,
      color: backGroundColor ?? theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          height: AppSize.s46,
          width: AppSize.s46,
          child: Padding(
            padding: EdgeInsets.only(
                left: leftPadding != null ? leftPadding! : AppPadding.p4,
               ),
            child: Transform.rotate(
              angle:  math.pi,
              child: Icon(
                icon ?? Icons.arrow_back_ios,
                color: iconColor ?? theme.primaryColorLight,
                size: AppSize.s22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
