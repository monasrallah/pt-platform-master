import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/shimmer_widget.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../getx/history_controller.dart';
import 'widget/add_food_widget.dart';
import 'widget/percent_widget.dart';
import 'widget/select_day_widget.dart';
import 'widget/target_widget.dart';

class NutritionHistoryPage extends GetView<HistoryController> {
  const NutritionHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.nutritionHistory.tr),
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
        child: Obx(
          () => Column(
            children: [
              controller.isLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: ShimmerWidget.rectangular(
                          height: 45.h, width: 1.sw, borderRadius: 12),
                    )
                  : const SelectDayWidget(),
              // 20.verticalSpace,
              controller.isLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: ShimmerWidget.rectangular(
                          height: 30.h, width: 1.sw, borderRadius: 12),
                    )
                  : const TargetWidget(),
              // 20.verticalSpace,
              controller.isLoading
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Container(
                        height: 80.h,
                      ),
                    )
                  : const PercentWidget(),
              40.verticalSpace,
              controller.isLoading
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: ShimmerWidget.rectangular(
                            height: 40.h,
                            borderRadius: 20.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: ShimmerWidget.rectangular(
                            height: 40.h,
                            borderRadius: 20.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: ShimmerWidget.rectangular(
                            height: 40.h,
                            borderRadius: 20.r,
                          ),
                        ),
                      ],
                    )
                  : const AddFoodWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
