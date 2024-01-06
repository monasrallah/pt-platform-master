import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/food/getx/food_controller.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/food/widget/edit_target_page.dart';
import 'package:pt_platform/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../../resources/strings_manager.dart';

class TargetWidget extends GetView<FoodController> {
  const TargetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            12.horizontalSpace,
            Text(AppStrings.target.tr),
          ],
        ),
        12.verticalSpace,
        Obx(
          () => controller.isLoading
              ? ShimmerWidget.rectangular(
                  height: 30.h,
                  borderRadius: 20.r,
                )
              : LinearPercentIndicator(
                  width: 1.sw - 50.w,
                  lineHeight: 30.h,
                  percent: (controller.foodEntity.value.foodTarget <=
                          controller.foodEntity.value.user.targetCalorie)
                      ? controller.foodEntity.value.foodTarget /
                          controller.foodEntity.value.user.targetCalorie
                              .toDouble()
                      : 1,
                  center: Text(
                    "${controller.foodEntity.value.foodTarget}/${controller.foodEntity.value.user.targetCalorie} Cal",
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  barRadius: Radius.circular(12.r),
                  backgroundColor: Colors.grey,
                  progressColor: (controller.foodEntity.value.foodTarget <=
                          controller.foodEntity.value.user.targetCalorie)
                      ? ColorManager.primary
                      : ColorManager.logout,
                ),
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                controller.fat.clear();
                controller.carbs.clear();
                controller.protein.clear();
                controller.calories.clear();
                Get.to(() =>
                    EditTargetPage(foodEntity: controller.foodEntity.value));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: ColorManager.primary,
                    size: 17.w,
                  ),
                  6.horizontalSpace,
                  Text(
                    AppStrings.editTarget.tr,
                    style:
                        Get.textTheme.displaySmall!.copyWith(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
