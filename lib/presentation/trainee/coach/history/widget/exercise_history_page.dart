import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/presentation/trainee/coach/history/getx/history_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/dialogs/coach_info_dialog.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class ExerciseHistoryPage extends GetView<HistoryController> {
  const ExerciseHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.exerciseHistory.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Obx(
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
            : controller.videos.isEmpty
                ? SizedBox(
                    height: 0.7.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.videos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.visible.value = false;
                          controller.visible.value = !controller.visible.value;
                          controller.selected.value = index;
                          controller.getExerciseLogs(
                              controller.videos[index].id);

                          // showAdaptiveDialog(
                          //   barrierDismissible: false,
                          //   context: Get.context!,
                          //   // useSafeArea: false,
                          //   builder: (context) {
                          //     return const ExerciseHistoryDialog(
                          //       header: 'plate Shrug',
                          //     );
                          //   },
                          // );
                        },
                        child: Obx(
                          () => Column(
                            children: [
                              buildExerciseCard(
                                image: controller.videos[index].image,
                                title: controller.videos[index].title,
                              ),
                              Visibility(
                                visible: controller.visible.value &&
                                    (controller.selected.value == index),
                                child: Obx(
                                  () => controller.isLoadingLogs
                                      ? const CircularProgressIndicator()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: SizedBox(
                                            width: 1.sw,
                                            // height: 500.h,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: controller.logs.length,
                                              itemBuilder: (context, index) {
                                                return historyRow(
                                                    date: controller
                                                        .logs[index].createdAt,
                                                    stone:
                                                        "${controller.logs[index].weight} ${controller.logs[index].weightUnit}",
                                                    num:
                                                        "${controller.logs[index].repetition}",
                                                    note: controller
                                                        .logs[index].note
                                                        .orEmpty());
                                              },
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget historyRow(
      {required String date,
      required String stone,
      required String num,
      required String note}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              date,
              style: Get.textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              stone,
              style: Get.textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              num,
              style: Get.textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomElevatedButton(
              title: AppStrings.note.tr,
              height: 40.h,
              backgroundColor: ColorManager.white,
              textStyle: Get.textTheme.displaySmall,
              onTap: () {
                Get.dialog(
                    InformationDialog(header: AppStrings.note.tr, coachDesc: note));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExerciseCard({required String image, required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: 1.sw,
            decoration: BoxDecoration(
              // color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          12.verticalSpace,
          Text(
            title,
            style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
