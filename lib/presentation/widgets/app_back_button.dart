import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';

class AppBackButton extends StatelessWidget {
  final void Function()? onTap;

  const AppBackButton({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Icon(
        Icons.arrow_back_ios_sharp,
        color: ColorManager.black,
      ),
    );
  }
}
