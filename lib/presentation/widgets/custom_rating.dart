import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../resources/color_manager.dart';

class CustomRating extends StatelessWidget {
  final double rate;
  final double itemSize;

  const CustomRating({required this.rate, required this.itemSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RatingBarIndicator(
        rating: rate,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: ColorManager.primary,
        ),
        unratedColor: ColorManager.iconGrey,
        itemCount: 5,
        itemSize: itemSize,
        direction: Axis.horizontal,
      ),
    );
  }
}
