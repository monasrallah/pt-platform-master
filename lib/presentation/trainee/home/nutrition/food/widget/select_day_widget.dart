import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/shimmer_widget.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../../resources/strings_manager.dart';
import '../getx/food_controller.dart';

class SelectDayWidget extends GetView<FoodController> {
  const SelectDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          20.verticalSpace,
          Container(
            height: 45.h,
            width: 1.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              controller.date.value,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
            ),
          ),
          // Obx(
          //   () => CustomElevatedButton(
          //     title: controller.date.value,
          //     textStyle: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
          //     height: 45.h,
          //     onTap: () async {
          //       // DateTime? pickedDate = await showDatePicker(
          //       //     context: context,
          //       //     initialDate: DateTime.now(),
          //       //     firstDate: DateTime.utc(1900),
          //       //     lastDate: DateTime.now(),
          //       //     // lastDate: DateTime(DateTime.now().year + 20),
          //       //     builder: (context, child) {
          //       //       return Theme(
          //       //         data: Theme.of(context).copyWith(
          //       //           shadowColor: Get.theme.colorScheme.background,
          //       //           timePickerTheme: TimePickerTheme.of(context).copyWith(
          //       //             //background color of time picker
          //       //             backgroundColor: Get.theme.colorScheme.background,
          //       //           ),
          //       //         ),
          //       //         child: child!,
          //       //       );
          //       //     });
          //       //
          //       // if (pickedDate != null) {
          //       //   controller.date.value = dateFormat(date: pickedDate);
          //       //   controller.selectedDate = pickedDate;
          //       //   // checkSelectedIfValidSelectedDate();
          //       // }
          //     },
          //   ),
          // ),
          20.verticalSpace,
          buildEquation(),
          10.verticalSpace,
        ],
      ),
    );
  }

  Widget buildEquation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(
        () => controller.isLoading
            ? ShimmerWidget.rectangular(height: 40.h, borderRadius: 12.r)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildColumnNumber(
                      upNum: controller.foodEntity.value.userTarget,
                      bottomText: AppStrings.target.tr),
                  const Text("-"),
                  buildColumnNumber(
                      upNum: controller.foodEntity.value.foodTarget,
                      bottomText: AppStrings.food.tr),
                  const Text("="),
                  buildColumnNumber(
                      upNum: controller.foodEntity.value.userTarget -
                          controller.foodEntity.value.foodTarget,
                      bottomText: AppStrings.remaining.tr,
                      color: ColorManager.primary),
                ],
              ),
      ),
    );
  }

  Widget buildColumnNumber(
      {required int upNum, required String bottomText, Color? color}) {
    return Column(
      children: [
        Text(
          upNum.toString(),
          style:
              Get.textTheme.bodyMedium!.copyWith(fontSize: 18.sp, color: color),
        ),
        Text(
          bottomText,
          style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
        ),
      ],
    );
  }
}
