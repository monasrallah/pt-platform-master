import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/food/getx/food_controller.dart';
import 'package:pt_platform/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../../../resources/strings_manager.dart';
import 'add_food_page.dart';

class AddFoodWidget extends GetView<FoodController> {
  const AddFoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isDeleteLoading
          ? const CircularProgressIndicator()
          : Column(
              children: [
                buildTextFieldWithTitle(
                  title: AppStrings.breakfast,
                  addText: AppStrings.addBreakfast.tr,
                  foods: controller.foodEntity.value.food.breakfast,
                  onDelete: (index) async {
                    await controller.openDeleteDialog(
                        controller
                            .foodEntity.value.food.breakfast![index].userFoodId,
                        controller
                            .foodEntity.value.food.breakfast![index].name);
                    controller.foodEntity.value.food.breakfast!.removeAt(index);
                  },
                ),
                buildTextFieldWithTitle(
                  title: AppStrings.lunch,
                  addText: AppStrings.addLunch.tr,
                  foods: controller.foodEntity.value.food.lunch,
                  onDelete: (index) async {
                    await controller.openDeleteDialog(
                        controller
                            .foodEntity.value.food.lunch![index].userFoodId,
                        controller.foodEntity.value.food.lunch![index].name);
                    controller.foodEntity.value.food.lunch!.removeAt(index);
                  },
                ),
                buildTextFieldWithTitle(
                  title: AppStrings.dinner,
                  addText: AppStrings.addDinner.tr,
                  foods: controller.foodEntity.value.food.dinner,
                  onDelete: (index) async {
                    await controller.openDeleteDialog(
                        controller
                            .foodEntity.value.food.dinner![index].userFoodId,
                        controller.foodEntity.value.food.dinner![index].name);
                    controller.foodEntity.value.food.dinner!.removeAt(index);
                  },
                ),
                buildTextFieldWithTitle(
                  title: AppStrings.snacks,
                  addText: AppStrings.addSnacks.tr,
                  foods: controller.foodEntity.value.food.snack,
                  onDelete: (index) async {
                    await controller.openDeleteDialog(
                        controller
                            .foodEntity.value.food.snack![index].userFoodId,
                        controller.foodEntity.value.food.snack![index].name);
                    controller.foodEntity.value.food.snack!.removeAt(index);
                  },
                ),
                buildTextFieldWithTitle(
                  title: AppStrings.supplements,
                  addText: AppStrings.addSupplements.tr,
                  foods: controller.foodEntity.value.food.supplements,
                  onDelete: (index) async {
                    await controller.openDeleteDialog(
                        controller.foodEntity.value.food.supplements![index]
                            .userFoodId,
                        controller
                            .foodEntity.value.food.supplements![index].name);
                    controller.foodEntity.value.food.supplements!
                        .removeAt(index);
                  },
                ),
              ],
            ),
    );
  }

  Widget buildTextFieldWithTitle(
      {required String title,
      required String addText,
      required Function onDelete,
      List<DishesEntity>? foods}) {
    return Obx(
      () => controller.isLoading
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: ShimmerWidget.rectangular(
                height: 40.h,
                borderRadius: 20.r,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr,
                  style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
                ),
                6.verticalSpace,
                if (foods != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key('item ${foods[index]}'),
                        background: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: ColorManager.lightRed,
                              ),
                              Icon(
                                Icons.delete_outline,
                                color: ColorManager.lightRed,
                              ),
                            ],
                          ),
                        ),
                        confirmDismiss: (DismissDirection direction) async {
                          await onDelete(index);
                          // if (direction == DismissDirection.startToEnd) {
                          //   print("Add to favorite");
                          // } else {
                          //   print('Remove item');
                          // }
                          return false;
                        },
                        child: buildFoodTile(
                            food: foods[index].title,
                            calorie: foods[index].calorie.toStringAsFixed(2)),
                      );
                    },
                  ),
                Container(
                  width: 1.sw,
                  height: 40.h,
                  color: Colors.grey.shade700,
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: InkWell(
                    onTap: () async {
                      Get.to(() => AddFoodPage(title: title));
                      await controller.getFood();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add,
                          color: ColorManager.primary,
                          size: 20.w,
                        ),
                        Text(
                          addText,
                          style: Get.textTheme.displaySmall!
                              .copyWith(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
    );
  }

  Widget buildFoodTile({required String food, required String calorie}) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 1,
          color: ColorManager.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
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
