import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/food_controller.dart';
import 'widget/add_food_widget.dart';
import 'widget/percent_widget.dart';
import 'widget/select_day_widget.dart';
import 'widget/target_widget.dart';

class FoodView extends GetView<FoodController> {
  const FoodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.food.tr),
      bodyWidget: Obx(
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
            : buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            const SelectDayWidget(),
            20.verticalSpace,
            const TargetWidget(),
            20.verticalSpace,
            const PercentWidget(),
            20.verticalSpace,
            const AddFoodWidget(),
          ],
        ),
      ),
    );
  }
}
