import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../../domain/entities/home_entities/food_entity.dart';
import '../../getx/history_controller.dart';

class AddFoodWidget extends GetView<HistoryController> {
  const AddFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.foodEntity.value.food.breakfast!.isEmpty
            ? const SizedBox.shrink()
            : buildTextFieldWithTitle(
                title: AppStrings.breakfast.tr,
                addText: AppStrings.addBreakfast.tr,
                foods: controller.foodEntity.value.food.breakfast,
              ),
        controller.foodEntity.value.food.lunch!.isEmpty
            ? const SizedBox.shrink()
            : buildTextFieldWithTitle(
                title: AppStrings.lunch.tr,
                addText: AppStrings.addLunch.tr,
                foods: controller.foodEntity.value.food.lunch,
              ),
        controller.foodEntity.value.food.dinner!.isEmpty
            ? const SizedBox.shrink()
            : buildTextFieldWithTitle(
                title: AppStrings.dinner.tr,
                addText: AppStrings.addDinner.tr,
                foods: controller.foodEntity.value.food.dinner,
              ),
        controller.foodEntity.value.food.snack!.isEmpty
            ? const SizedBox.shrink()
            : buildTextFieldWithTitle(
                title: AppStrings.snacks.tr,
                addText: AppStrings.addSnacks.tr,
                foods: controller.foodEntity.value.food.snack,
              ),
        controller.foodEntity.value.food.supplements!.isEmpty
            ? const SizedBox.shrink()
            : buildTextFieldWithTitle(
                title: AppStrings.supplements.tr,
                addText: AppStrings.addSupplements.tr,
                foods: controller.foodEntity.value.food.supplements,
              ),
      ],
    );
  }

  Widget buildTextFieldWithTitle(
      {required String title,
      required String addText,
      List<DishesEntity>? foods}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Container(
            width: 1.sw,
            height: 1,
            color: ColorManager.grey,
          ),
        ),
        6.verticalSpace,
        if (foods != null)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return buildFoodTile(
                  food: foods[index].title,
                  calorie: foods[index].calorie.toStringAsFixed(2));
            },
          ),
        20.verticalSpace,
      ],
    );
  }

  Widget buildFoodTile({required String food, required String calorie}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  food,
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      AppStrings.calorie.tr,
                      style:
                          Get.textTheme.displaySmall!.copyWith(fontSize: 15.sp),
                    ),
                    Text(
                      calorie,
                      style:
                          Get.textTheme.displaySmall!.copyWith(fontSize: 15.sp),
                    ),
                  ],
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
    );
  }
}
