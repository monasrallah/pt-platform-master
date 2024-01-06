import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 60,
      start: 20,
      child: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_sharp,
          color: ColorManager.primary,
          size: 30.w,
        ),
      ),
    );
  }
}
