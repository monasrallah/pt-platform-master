import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/entities/home_entities/food_entity.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/food/getx/food_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../domain/parameters/home_params/update_target_params.dart';
import '../../../../../../resources/strings_manager.dart';
import '../../../../../widgets/buttons/app_back_bar.dart';
import '../../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class EditTargetPage extends GetView<FoodController> {
  const EditTargetPage({required this.foodEntity, Key? key}) : super(key: key);

  final FoodEntity foodEntity;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(
          title: AppStrings.nutrition,
          withAction: true,
          onTapAction: () async {
            await launchUrl(Uri.parse(
                "https://www.nal.usda.gov/programs/fnic#:~:text=Carbohydrates%20provide%204%20calories%20per,Facts%20label%20on%20food%20packages"));
          }),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    controller.carbs.text = foodEntity.user.targetCarb.toString();
    controller.fat.text = foodEntity.user.targetFat.toString();
    controller.protein.text = foodEntity.user.targetProtein.toString();
    controller.calculatorNewTarget();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Text(
              AppStrings.setYourTarget.tr,
              style: Get.textTheme.bodyLarge,
            ),
            20.verticalSpace,
            buildTextFieldWithTitle(
                title: AppStrings.carbs.tr, textController: controller.carbs),
            buildTextFieldWithTitle(
                title: AppStrings.fat.tr, textController: controller.fat),
            buildTextFieldWithTitle(
                title: AppStrings.protein.tr,
                textController: controller.protein),
            buildTextFieldWithTitle(
                title: AppStrings.calories.tr,
                readOnly: true,
                textController: controller.calories),
            40.verticalSpace,
            Obx(
              () => controller.isLoading
                  ? SizedBox(
                      width: 1.sw,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : CustomElevatedButton(
                      title: AppStrings.save.tr,
                      onTap: () async {
                        controller.foodEntity.value = FoodEntity.copyWith(
                            FoodEntity(
                                userTarget: controller.calories.text.isEmpty
                                    ? controller.foodEntity.value.userTarget
                                    : int.parse(controller.calories.text),
                                user: controller.foodEntity.value.user,
                                foodTarget:
                                    controller.foodEntity.value.foodTarget,
                                exerciseTarget:
                                    controller.foodEntity.value.exerciseTarget,
                                carb: controller.carbs.text.isEmpty
                                    ? controller.foodEntity.value.carb
                                    : int.parse(controller.carbs.text),
                                fat: controller.fat.text.isEmpty
                                    ? controller.foodEntity.value.fat
                                    : int.parse(controller.fat.text),
                                protein: controller.protein.text.isEmpty
                                    ? controller.foodEntity.value.protein
                                    : int.parse(controller.protein.text),
                                food: controller.foodEntity.value.food));

                        await controller.editTarget(UpdateTargetParams(
                          target_calorie: controller.calories.text.isEmpty
                              ? controller.foodEntity.value.userTarget
                              : int.parse(controller.calories.text),
                          target_carb: controller.carbs.text.isEmpty
                              ? controller.foodEntity.value.carb
                              : int.parse(controller.carbs.text),
                          target_fat: controller.fat.text.isEmpty
                              ? controller.foodEntity.value.fat
                              : int.parse(controller.fat.text),
                          target_protein: controller.protein.text.isEmpty
                              ? controller.foodEntity.value.protein
                              : int.parse(controller.protein.text),
                        ));
                        controller.getFoodHistory();
                      }),
            ),
            20.verticalSpace,
            SizedBox(
              width: 0.8.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.editTargetDes1.tr,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Example: ",
                        style:
                            Get.textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                        children: [
                          TextSpan(
                            text: AppStrings.editTargetDes2.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 15.sp),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldWithTitle(
      {required String title,
      required TextEditingController textController,
      bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
        ),
        6.verticalSpace,
        CustomTextField(
          hint: "",
          textInputType: TextInputType.number,
          textEditingController: textController,
          filled: true,
          fillColor: ColorManager.grey,
          readOnly: readOnly,
          onSubmit: (value) {
            controller.calculatorNewTarget();
          },
          onChanged: (value) {
            controller.calculatorNewTarget();
          },
          onTap: () {
            controller.calculatorNewTarget();
          },
          onTapOutside: () {
            controller.calculatorNewTarget();
          },
        ),
        15.verticalSpace,
      ],
    );
  }
}
