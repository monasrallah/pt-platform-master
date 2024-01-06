import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget child;
  final Function? onTap;
  final Color? color;

  const CustomFloatingActionButton({
    Key? key,
    this.onTap,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        width: 90.w,
        height: 90.h,
        child: FloatingActionButton(
            elevation: 12,
            backgroundColor: color ?? theme.primaryColor,
            onPressed: onTap != null
                ? () {
                    onTap!();
                  }
                : null,
            child: child));
  }
}

class CustomFloatingIcon extends StatelessWidget {
  final IconData icon;

  const CustomFloatingIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white,
      size: 35.w,
    );
  }
}
