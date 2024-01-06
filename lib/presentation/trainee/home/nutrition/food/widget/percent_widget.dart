import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/food/getx/food_controller.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../../resources/strings_manager.dart';
import '../../../../../widgets/custom_percent_indeicator.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';

class PercentWidget extends GetView<FoodController> {
  const PercentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();
    print(controller.foodEntity.value.userTarget);

    return Obx(
      () => controller.isLoading
          ? SizedBox(
              height: 250.h,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Column(
              children: [
                30.verticalSpace,
                AnimatedCircularChart(
                  key: chartKey,
                  size: Size(150.h, 100.w),
                  initialChartData: <CircularStackEntry>[
                    buildCircularStackEntry(
                        completed:
                            (controller.foodEntity.value.foodTarget * 100) /
                                controller.foodEntity.value.user.targetCalorie
                                    .toDouble(),
                        remaining: 1),
                    buildCircularStackEntry(
                        completed:
                            (controller.foodEntity.value.foodTarget * 100) /
                                controller.foodEntity.value.user.targetCalorie
                                    .toDouble(),
                        remaining: 1),
                    buildCircularStackEntry(
                        completed:
                            (controller.foodEntity.value.foodTarget * 100) /
                                controller.foodEntity.value.user.targetCalorie
                                    .toDouble(),
                        remaining: 1),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: '${controller.foodEntity.value.userTarget}Cal',
                  holeRadius: 50.r,
                  edgeStyle: SegmentEdgeStyle.round,
                  labelStyle: Get.textTheme.bodySmall,
                ),
                50.verticalSpace,
                Row(
                  children: [
                    CustomCircularPercentIndicator(
                        centers: [
                          Text(
                            "${controller.foodEntity.value.carb}" "g",
                            style: Get.textTheme.bodySmall,
                          ),
                          Container(
                            height: 0.5,
                            width: 40,
                            color: ColorManager.white,
                          ),
                          Text(
                            AppStrings.carbs.tr,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                        progressColor: Colors.blue,
                        percent: controller.foodEntity.value.carb >
                                controller.foodEntity.value.user.targetProtein
                                    .toDouble()
                            ? 1
                            : controller.foodEntity.value.carb /
                                controller.foodEntity.value.user.targetCarb
                                    .toDouble()),
                    CustomCircularPercentIndicator(
                        centers: [
                          Text(
                            "${controller.foodEntity.value.fat}" "g",
                            style: Get.textTheme.bodySmall,
                          ),
                          Container(
                            height: 0.5,
                            width: 40,
                            color: ColorManager.white,
                          ),
                          Text(
                            AppStrings.fat.tr,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                        progressColor: Colors.red,
                        percent: controller.foodEntity.value.fat >
                                controller.foodEntity.value.user.targetProtein
                                    .toDouble()
                            ? 1
                            : controller.foodEntity.value.fat /
                                controller.foodEntity.value.user.targetFat
                                    .toDouble()),
                    CustomCircularPercentIndicator(
                        centers: [
                          Text(
                            "${controller.foodEntity.value.protein}" "g",
                            style: Get.textTheme.bodySmall,
                          ),
                          Container(
                            height: 0.5,
                            width: 40,
                            color: ColorManager.white,
                          ),
                          Text(
                            AppStrings.protein.tr,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                        progressColor: ColorManager.primary,
                        percent: controller.foodEntity.value.protein >
                                controller.foodEntity.value.user.targetProtein
                                    .toDouble()
                            ? 1
                            : controller.foodEntity.value.protein /
                                controller.foodEntity.value.user.targetProtein
                                    .toDouble())
                  ],
                ),
              ],
            ),
    );
  }

  CircularStackEntry buildCircularStackEntry({
    required double completed,
    required double remaining,
  }) {
    return CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(
          completed,
          ColorManager.primary,
          rankKey: 'completed',
        ),
        CircularSegmentEntry(
          remaining,
          ColorManager.darkGrey,
          rankKey: 'remaining',
        ),
      ],
      rankKey: 'progress',
    );
  }
}
