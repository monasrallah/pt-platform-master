import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../domain/entities/coach_entities/shop_entity.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../getx/shop_controller.dart';

class ShopDetailsPage extends GetView<ShopController> {
  const ShopDetailsPage({required this.personalTraining, Key? key})
      : super(key: key);
  final PersonalTrainingEntity personalTraining;

  @override
  Widget build(BuildContext context) {
    Get.put(CoachController());
    controller.discount = false.obs;

    return WillPopScope(
      onWillPop: () async {
        controller.discount.value = false;
        controller.codeController.clear();
        Get.back();
        return true;
      },
      child: MainBottomNavigationBar(
        appBarWidget: appBackBar(
            title: AppStrings.pTPackages.tr,
            onTap: () => {
                  controller.discount.value == false,
                  Get.back(),
                  controller.codeController.clear()
                }),
        backgroundColor: Colors.white24,
        bodyWidget: buildBody(),
      ),
    );
  }

  Widget buildBody() {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 1.sw,
            color: Colors.grey.shade700,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Get.find<CoachController>().coachName.value),
                Text(
                  personalTraining.description,
                  style: Get.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          20.verticalSpace,
          if (personalTraining.permissions != null)
            Container(
              width: 1.sw,
              color: Colors.grey.shade600.withOpacity(0.4),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.packageFeatures.tr),
                  10.verticalSpace,
                  Text(
                    "${AppStrings.videoCall.tr}: ${personalTraining.permissions!.callVideo}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                  ),
                  10.verticalSpace,
                  Text(
                    "${AppStrings.workoutSchedule.tr}: ${personalTraining.permissions!.workoutSchedule}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                  ),
                  10.verticalSpace,
                  Text(
                    "${AppStrings.foodPlan.tr}: ${personalTraining.permissions!.foodPlan}",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.paymentMethod.tr),
                // Text(
                //   "Its Contain workout plan, nutation plan and zoom call",
                //   style: Get.textTheme.bodySmall,
                // ),
                30.verticalSpace,
                buildPromoCode(),
                30.verticalSpace,

                buildRow(
                    first: AppStrings.duration.tr,
                    second: '${personalTraining.date} ${AppStrings.months.tr}'),

                Obx(
                  () => (controller.discount.value)
                      ? buildRow(
                          first: AppStrings.discount.tr,
                          second: controller.discountEntity.discount)
                      : Container(),
                ),
                Obx(
                  () => buildRow(
                    first: AppStrings.price.tr,
                    second: (!controller.discount.value)
                        ? personalTraining.priceObject.formatted
                        : controller.discountEntity.price.toString().length >= 5
                            ? controller.discountEntity.price
                                .toString()
                                .substring(0, 5)
                            : controller.discountEntity.price.toString(),
                  ),
                ),
                30.verticalSpace,
                Obx(
                  () => controller.isLoading
                      ? SizedBox(
                          width: 1.sw,
                          height: 50.h,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : CustomElevatedButton(
                          title: AppStrings.payViaCreditCard.tr,
                          backgroundColor: Colors.blue,
                          onTap: () {
                            controller.checkout(personalTraining.id, "stripe");
                          },
                        ),
                ),
                20.verticalSpace,
                Obx(
                  () => controller.isLoading
                      ? SizedBox(
                          width: 1.sw,
                          height: 50.h,
                        )
                      : CustomElevatedButton(
                          title: AppStrings.payWithInAppPurchase.tr,
                          onTap: () {
                            controller.checkout(
                                personalTraining.id, "purchase");
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow({required String first, required String second}) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
          ),
          Text(
            second,
            style: Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
          ),
        ],
      ),
    );
  }

  Widget buildPromoCode() {
    print("test ${controller.discount.value}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.promoCode.tr),
        6.verticalSpace,
        promoCodeTextField(),
      ],
    );
  }

  Widget promoCodeTextField() {

    return Row(
      children: [
        Expanded(
          flex: 3,
          child:    CustomTextField(
              onChanged:(value){

              },
              height: 60,
              textEditingController: controller.codeController,
              contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 1.5.h, vertical: 12.h),
              hint: "",
              prefix: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Obx(
                  () => controller.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: 100.w,
                          child: CustomElevatedButton(
                            title: AppStrings.apply.tr,
                            height: 30.h,
                            textStyle: Get.textTheme.bodyMedium!
                                .copyWith(fontSize: 17.sp, height: 0.5),
                            onTap: () async {
                              await controller
                                  .checkPromoCode(personalTraining.id);
                            },
                          ),
                        ),
                ),
              ),
            ),
          ),

        // 12.horizontalSpace,
        // Expanded(
        //   flex: 1,
        //   child: CustomElevatedButton(
        //     title: 'Apply',
        //     height: 40,
        //     textStyle: Get.textTheme.bodyMedium!
        //         .copyWith(fontSize: 17.sp, height: 0.5),
        //     onTap: () {},
        //   ),
        // ),
      ],
    );
  }
}
