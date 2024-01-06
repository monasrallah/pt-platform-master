import 'package:flutter/material.dart';

import '../../../resources/value_manager.dart';


class OutLinedButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color borderColor;
  final double height;
  final double width;
  final double borderWidth;
  final double elevation;
  final TextStyle? textStyle;

  const OutLinedButton(
      {required this.title,
      required this.onPress,
      required this.borderColor,
      required this.height,
      required this.width,
      required this.textStyle,
      required this.elevation,
      required this.borderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: elevation,
          side: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
            width: borderWidth,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s20)),
        ),
        onPressed: () => onPress(),
        child: Text(
          title,
          style: textStyle,

        ),
      ),
    );
  }
}
