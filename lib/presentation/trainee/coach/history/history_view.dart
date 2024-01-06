import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/history_controller.dart';
import 'widget/exercise_history_page.dart';
import 'widget/nutrtion_history_page.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.history.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(color: controller.color),
          CustomElevatedButton(
            height: 75.h,
            title: AppStrings.exerciseHistory.tr,
            onTap: () async {
              Get.to(() => const ExerciseHistoryPage());
              await controller.getExerciseHistory();
            },
          ),
          30.verticalSpace,
          CustomElevatedButton(
            height: 75.h,
            title: AppStrings.nutritionHistory.tr,
            onTap: () async {
              Get.to(() => const NutritionHistoryPage());
              await controller.getFoodHistory();
            },
          ),
          300.verticalSpace,
        ],
      ),
    );
  }
}
