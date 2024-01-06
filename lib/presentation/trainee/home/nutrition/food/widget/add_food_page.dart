import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/presentation/widgets/dialogs/add_food_dialog/add_food_controller.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../widgets/buttons/app_back_bar.dart';
import '../../../../../widgets/dialogs/add_food_dialog/add_food_dialog.dart';
import '../../../../../widgets/toasts_messages.dart';
import '../../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../getx/food_controller.dart';

class AddFoodPage extends GetView<FoodController> {
  const AddFoodPage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.addFoods.tr),
      bodyWidget: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Column(
      children: [
        Obx(
          () => buildFoodTile(
              first: controller.foodSelected.value,
              second: Icon(
                Icons.keyboard_arrow_down,
                color: ColorManager.white,
                size: 25.w,
              ),
              onTap: () async {
                Get.lazyPut(() => AddFoodController());
                showAdaptiveDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AddFoodDialog(
                      onTap: (AddFoodEntity select) {
                        controller.foodSelected.value = select.title;
                        controller.foodId.value = select.id;
                        controller.selectedFood.value = select;
                        controller.calculateFood();
                      },
                      selectedItem: controller.selectedFood.value,
                      titles: controller.addFoods,
                    );
                  },
                );
              }),
        ),
        buildFoodTile(
          first: AppStrings.gramOfServings.tr,
          second: buildInDecreaseNumber(),
        ),
        30.verticalSpace,
        buildCalRow(),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(
            () => controller.isLoading
                ? SizedBox(
                    width: 1.sw,
                    // height: 0.2.sh,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : CustomElevatedButton(
                    title: AppStrings.save.tr,
                    onTap: () {
                      if (controller.foodSelected.value.isNotEmpty) {
                        controller.addFood(title);
                      } else {
                        showFlutterToast(
                            message: AppStrings.pleaseSelectFood.tr);
                      }
                    },
                  ),
          ),
        ),
        100.verticalSpace,
      ],
    );
  }

  Widget buildFoodTile(
      {required String first, required Widget second, Function? onTap}) {
    return InkWell(
      onTap: onTap != null ? () => onTap() : null,
      child: Column(
        children: [
          Container(
            width: 1.sw,
            height: 1,
            color: ColorManager.grey,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    first,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: second,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.sw,
            height: 1,
            color: ColorManager.grey,
          ),
        ],
      ),
    );
  }

  Widget buildInDecreaseNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTapDown: (details) {
            controller.isPress.value = true;
            controller.decrease();
          },
          onTapUp: (details) {
            controller.isPress.value = false;
            controller.calculateFood();
            // controller.increase();
          },
          child: Container(
            height: 40.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.minimize,
              color: ColorManager.white,
              size: 23.w,
            ),
          ),
        ),
        Expanded(
          child: CustomTextField(
            hint: "",
            textEditingController: controller.counterString,
            isUnderLineBorderStyle: true,
            textAlign: TextAlign.center,
            textInputType: TextInputType.number,
            contentPadding: EdgeInsetsDirectional.zero,
          ),
        ),
        // Obx(
        //   () => RichText(
        //     text: TextSpan(
        //         text: "${controller.counter.value}",
        //         style: Get.textTheme.bodyMedium,
        //         children: [
        //           TextSpan(text: "g", style: Get.textTheme.bodySmall)
        //         ]),
        //   ),
        // ),
        GestureDetector(
          onTapDown: (details) {
            controller.isPress.value = true;
            controller.increase();
          },
          onTapUp: (details) {
            controller.isPress.value = false;
            controller.calculateFood();
            // controller.increase();
          },
          child: Container(
            height: 40.h,
            width: 30.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Icon(
              Icons.add,
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCalRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCalColumn(
                up: controller.calorieFood.value,
                bottom: AppStrings.cal.tr,
                color: ColorManager.white),
            buildCalColumn(
                up: controller.carbsFood.value,
                bottom: AppStrings.carbs.tr,
                color: Colors.blue),
            buildCalColumn(
                up: controller.fatFood.value,
                bottom: AppStrings.fat.tr,
                color: Colors.red),
            buildCalColumn(
                up: controller.proteinFood.value,
                bottom: AppStrings.protein.tr,
                color: ColorManager.primary),
          ],
        ),
      ),
    );
  }

  Widget buildCalColumn(
      {required String up, required String bottom, required Color color}) {
    return Column(
      children: [
        Text(
          up,
          style: Get.textTheme.bodySmall,
        ),
        10.verticalSpace,
        Text(
          bottom,
          style: Get.textTheme.bodyMedium!.copyWith(
            color: color,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}
