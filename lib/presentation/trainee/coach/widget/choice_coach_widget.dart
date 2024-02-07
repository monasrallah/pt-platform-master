import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../domain/core/entities/failure.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/bottom_sheet/custom_wheel_scroll_widget.dart';
import 'tips_page.dart';

class ChoiceCoachWidget extends GetView<CoachController> {
  const ChoiceCoachWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: InkWell(
        onTap: () {
          print(
              "Test ${controller.coaches.map((e) => e.lastName.orEmpty()).toList()}");
          Get.bottomSheet(
            CustomWheelScrollWidget(
              data: controller.coachName,
              index: controller.coachIndex,
              dataList:
                  controller.coaches.map((e) => e.lastName.orEmpty()).toList(),
            ),
            // buildWheelScroll(),
          );
          controller.coachId.value =
              controller.coaches[controller.coachIndex.value].id.toString();
          controller.coachName.value = controller
              .coaches[controller.coachIndex.value].lastName
              .toString();
          controller.coachAvatar.value =
              controller.coaches[controller.coachIndex.value].logo.toString();

          print("testgetUserEntity${controller.coachAvatar.value}");
        },
        child: Stack(
          children: [
            Container(
              height: 220.h,
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: 23.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Obx(
                () => controller.failure.value.message != null
                    ? IconButton(
                        onPressed: () async {
                          controller.failure.value = Failure.Default();
                          await controller.getAssignedCoaches();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: ColorManager.primary,
                          size: 40.w,
                        ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 130.h,
                            width: 130.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                  color: ColorManager.lightPrimary, width: 10),
                            ),
                            child: Obx(
                              () => controller.isLoading
                                  ? const CircularProgressIndicator()
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      child: Image.network(
                                        controller.coachAvatar.value,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          10.verticalSpace,
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 40.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.coachName.value,
                                    style: Get.textTheme.bodySmall!
                                        .copyWith(fontSize: 22.sp),
                                  ),
                                ),
                                // const Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: ColorManager.primary,
                                ),
                                20.horizontalSpace,
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            PositionedDirectional(
              top: 15,
              end: 20,
              child: InkWell(
                onTap: () async {
                  Get.to(() => const TipsPage());
                  await controller.getTips();
                },
                child: Container(
                  // height: 30,
                  // width: 60,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Text(
                    AppStrings.tips.tr,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
