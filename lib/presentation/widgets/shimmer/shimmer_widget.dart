import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;

  final double height;

  final ShapeBorder shapeBorder;

  final Color? baseColor;

  final Color? highlightColor;
  final double? borderRadius;

  const ShimmerWidget.rectangular(
      {Key? key,
        this.width = double.infinity,
        required this.height,
        this.baseColor,
        this.borderRadius,
        this.highlightColor})
      : shapeBorder = const RoundedRectangleBorder(),
        super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    this.baseColor,
    this.borderRadius,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[400]!,
      highlightColor: highlightColor ?? Colors.grey[300]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      ),
    );
  }
}
