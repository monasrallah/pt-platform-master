import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../../widgets/custom_check_box.dart';
import '../../../../widgets/bottom_sheet/custom_wheel_scroll_widget.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/calorie_calculator_controller.dart';

class CalorieCalculatorView extends GetView<CalorieCalculatorController> {
  const CalorieCalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(
          title: AppStrings.caloriesCalculator.tr,
          withAction: true,
          onTapAction: () async {
            await launchUrl(Uri.parse(
                "https://www.mayoclinic.org/healthy-lifestyle/weight-loss/in-depth/calorie-calculator/itt-20402304"));
          }),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Text(
              AppStrings.setYourTarget.tr,
              style: Get.textTheme.bodyLarge!.copyWith(fontSize: 35.sp),
            ),
            30.verticalSpace,
            Obx(
              () => CustomTextField(
                hint: AppStrings.age.tr,
                textEditingController: controller.age,
                textInputType: TextInputType.number,
                filled: true,
                color: Colors.grey,
                errorText:
                    controller.ageValid.value ? null : AppStrings.invalidAge.tr,
                fillColor: ColorManager.grey,
              ),
            ),
            20.verticalSpace,
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppStrings.gender.tr),
                  Row(
                    children: [
                      CustomCheckbox(
                        isChecked: controller.isMale.value,
                        onTap: () {
                          if (!controller.isMale.value) {
                            controller.isMale.value = !controller.isMale.value;
                          }
                        },
                      ),
                      Text(
                        AppStrings.male.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomCheckbox(
                        isChecked: !controller.isMale.value,
                        onTap: () {
                          if (controller.isMale.value) {
                            controller.isMale.value = !controller.isMale.value;
                          }
                        },
                      ),
                      Text(
                        AppStrings.female.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Obx(
              () => CustomTextField(
                hint: AppStrings.height.tr,
                textEditingController: controller.height,
                textInputType: TextInputType.number,
                filled: true,
                color: Colors.grey,
                errorText: controller.heightValid.value
                    ? null
                    : AppStrings.invalidHeight,
                fillColor: ColorManager.grey,
              ),
            ),
            10.verticalSpace,
            Obx(
              () => CustomTextField(
                hint: AppStrings.weight.tr,
                textEditingController: controller.weight,
                textInputType: TextInputType.number,
                filled: true,
                fillColor: ColorManager.grey,
                errorText: controller.weightValid.value
                    ? null
                    : AppStrings.invalidWeight.tr,
                color: Colors.grey,
              ),
            ),
            10.verticalSpace,
            Obx(
              () => CustomTextField(
                height: 50.h,
                hint: AppStrings.active.tr,
                readOnly: true,
                filled: true,
                color: Colors.grey,
                fillColor: ColorManager.grey,
                errorText: controller.activeValid.value
                    ? null
                    : AppStrings.invalidActive.tr,
                textEditingController:
                    TextEditingController(text: controller.active.value),
                onChanged: (value) {
                  controller.active.value = value;
                },
                onTap: () {
                  controller.active.value = controller.actives[0];
                  return Get.bottomSheet(
                    CustomWheelScrollWidget(
                      data: controller.active,
                      dataList: controller.actives,
                    ),
                    // buildWheelScroll(),
                  );
                },
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: ColorManager.primary,
                  size: 25.w,
                ),
              ),
            ),
            50.verticalSpace,
            Obx(
              () => Visibility(
                visible: controller.visible.value,
                child: Center(
                  child: Text(controller.value.value.toStringAsFixed(2)),
                ),
              ),
            ),
            50.verticalSpace,
            CustomElevatedButton(
              title: AppStrings.calculate.tr,
              onTap: () {
                controller.calculate();
              },
            ),
            30.verticalSpace,
            Text(
              AppStrings.caloriesCalculatorDes1.tr,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
            Text(
              AppStrings.caloriesCalculatorDes2.tr,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
            Text(
              AppStrings.caloriesCalculatorDes3.tr,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
