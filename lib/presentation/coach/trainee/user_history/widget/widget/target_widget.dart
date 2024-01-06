import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../getx/history_controller.dart';

class TargetWidget extends GetView<UserHistoryCoachController> {
  const TargetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 12.verticalSpace,
        LinearPercentIndicator(
          width: 1.sw - 50.w,
          lineHeight: 30.h,
          percent: (controller.foodEntity.value.foodTarget <=
                  controller.foodEntity.value.user.targetCalorie)
              ? controller.foodEntity.value.foodTarget /
                  controller.foodEntity.value.user.targetCalorie.toDouble()
              : 1,
          center: Text(
            "${controller.foodEntity.value.foodTarget}/${controller.foodEntity.value.user.targetCalorie} Cal",
            style: const TextStyle(fontSize: 12.0),
          ),
          barRadius: Radius.circular(12.r),
          backgroundColor: Colors.grey,
          progressColor: ColorManager.primary,
        ),
        12.verticalSpace,
      ],
    );
  }
}
