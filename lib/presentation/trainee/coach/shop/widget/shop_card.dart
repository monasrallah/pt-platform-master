import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../data/coach/models/shop_model.dart';
import '../../../../../domain/entities/coach_entities/shop_entity.dart';
import '../../../../../resources/assets_manager.dart';
import '../getx/shop_controller.dart';
import 'shop_details_page.dart';

class ShopCard extends GetView<ShopController> {
  const ShopCard(
      {required this.image, Key? key, required this.personalTraining})
      : super(key: key);
  final String image;
  final PersonalTrainingEntity personalTraining;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 0.55.sw,
          height: 0.5.sh,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        PositionedDirectional(
          top: 45,
          start: 10,
          child: SizedBox(
            width: 0.5.sw,
            child: Text(
              personalTraining.description,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
          ),
        ),
        PositionedDirectional(
          top: 0.14.sh,
          start: 10,
          child: SizedBox(
            width: 0.5.sw,
            child: Text(
              "${personalTraining.priceObject.formatted} ",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
            ),
          ),
        ),
        PositionedDirectional(
          top: 0.19.sh,
          start: 10.w,
          child: SizedBox(
            width: 0.5.sw,
            child: Text(
              personalTraining.style != Style.STYLE_FREE ? "${personalTraining.date} month" : "7 days",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
            ),
          ),
        ),
        if (personalTraining.permissions != null)
          PositionedDirectional(
            top: 0.33.sh,
            start: 10.w,
            child: SizedBox(
              width: 0.5.sw,
              child: Column(
                children: [
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
          ),
        PositionedDirectional(
          bottom: 10.h,
          start: 0.1.sw,
          child: CustomElevatedButton(
            width: 0.35.sw,
            height: 40.h,
            title: AppStrings.buyNow.tr,
            elevation: 0,
            textStyle: Get.textTheme.bodySmall,
            // backgroundColor: Colors.grey.withOpacity(0.5),
            // backgroundColor: Colors.yellow.withOpacity(0.3),
            backgroundColor: image == ImageAssets.gold
                ? Colors.yellow.withOpacity(0.3)
                : image == ImageAssets.silver
                    ? Colors.grey.withOpacity(0.5)
                    : image == ImageAssets.manBackground
                        ? Colors.black.withOpacity(0.8)
                        : Colors.redAccent.withOpacity(0.3),
            borderRadius: BorderRadius.circular(22.r),
            onTap: () {
              return personalTraining.isFree
                  ? controller.checkoutFree(personalTraining.id, "free")
                  : Get.to(
                      () => ShopDetailsPage(personalTraining: personalTraining),
                    );
            },
          ),
        ),
      ],
    );
  }
}
