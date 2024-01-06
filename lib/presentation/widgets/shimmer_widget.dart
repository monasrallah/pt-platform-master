import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerWidget extends StatelessWidget {
  final double width;

  final double height;

  final ShapeBorder? shapeBorder;
  final double? borderRadius;
  final Color? baseColor;

  final Color? highlightColor;

  const ShimmerWidget.rectangular(
      {Key? key,
      this.width = double.infinity,
      required this.height,
      this.baseColor,
      this.highlightColor,
      this.shapeBorder = const RoundedRectangleBorder(),
      this.borderRadius})
      : super(key: key);

  const ShimmerWidget.circular(
      {Key? key,
      required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder(),
      this.baseColor,
      this.highlightColor,
      this.borderRadius})
      : super(key: key);

  const ShimmerWidget.rounderRectangleBorder(
      {Key? key,
      required this.width,
      required this.height,
      this.baseColor,
      this.highlightColor,
      required this.borderRadius,
      this.shapeBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: borderRadius != null
            ? BoxDecoration(
                color: Colors.grey[300]!,
                borderRadius: BorderRadius.circular(borderRadius!))
            : ShapeDecoration(
                color: Colors.grey[300]!,
                shape: shapeBorder!,
              ),
      ),
    );
  }
}
