import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../widgets/buttons/app_back_bar.dart';
import '../getx/history_controller.dart';
import 'widget/add_food_widget.dart';
import 'widget/percent_widget.dart';
import 'widget/select_day_widget.dart';
import 'widget/target_widget.dart';

class NutritionUserHistoryCoachPage
    extends GetView<UserHistoryCoachController> {
  const NutritionUserHistoryCoachPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBackBar(title: AppStrings.nutritionHistory.tr),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Obx(
          () => controller.isLoading
              ? SizedBox(
                  width: 1.sw,
                  height: 0.7.sh,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SelectDayWidget(),
                    // 20.verticalSpace,
                    const TargetWidget(),
                    // 20.verticalSpace,
                    const PercentWidget(),
                    40.verticalSpace,
                    const AddFoodWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
