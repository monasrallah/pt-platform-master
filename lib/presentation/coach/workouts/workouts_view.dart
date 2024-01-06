import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/coach/workouts/getx/workout_controller.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../resources/strings_manager.dart';
import '../../widgets/exercies_search_page.dart';
import 'widget/workout_video_page.dart';
import 'widget/workouts_list_widget.dart';

class WorkoutCoachView extends GetView<WorkoutsCoachController> {
  const WorkoutCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.25.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            SizedBox(
              height: 0.40.sh,
              width: 1.sw,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade600.withOpacity(0.5),
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  ImageAssets.backAppBar,
                  height: 0.40.sh,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorManager.primary,
                          size: 30.w,
                        ),
                      ),
                      40.horizontalSpace,
                      Text(
                        AppStrings.workouts.tr,
                        style: Get.textTheme.displayLarge!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  CustomTextField(
                    hint: AppStrings.search.tr,
                    hintStyle: Get.textTheme.displayMedium!,
                    textEditingController: controller.search,
                    filled: true,
                    style: Get.textTheme.displayMedium,
                    contentPadding:
                        EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
                    fillColor: ColorManager.white,
                    suffixIcon: InkWell(
                      onTap: () async {
                        await controller.getWorkOut();
                        Get.to(() => ExerciseSearchPage(
                              exercises: controller.exercise,
                              onTap: (index) async {
                                controller.getWorkOutVideo(
                                    controller.exercise[index].id);
                                Get.off(
                                  () => const WorkoutCoachVideoPage(),
                                );
                              },
                              // onWillPop: () => Get.back(),
                              onWillPop: () {
                                return;
                              },
                            ));

                        return;
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.search,
                          color: ColorManager.white,
                          size: 30.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 0.21.sh, start: 20.w, end: 20.w),
              child: SizedBox(
                height: 45.h,
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
                      : controller.sections.isEmpty
                          ? SizedBox(
                              height: 0.7.sh,
                              width: 1.sw,
                              child: SvgPicture.asset(IconsAssets.noData),
                            )
                          : ListView.builder(
                              itemCount: controller.sections.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.sectionSelect.value = index;
                                    },
                                    child: buildSection(
                                        title: controller.sections[index].title,
                                        color: controller.sectionSelect.value ==
                                                index
                                            ? ColorManager.primary
                                            : Colors.transparent),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
              : controller
                      .sections[controller.sectionSelect.value].category.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller
                          .sections[controller.sectionSelect.value]
                          .category
                          .length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return WorkoutCoachListWidget(
                          title: controller
                              .sections[controller.sectionSelect.value]
                              .category[index]
                              .title,
                          workout: controller
                              .sections[controller.sectionSelect.value]
                              .category[index]
                              .exercises,
                        );
                      },
                    ),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required Color color}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w),
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          title,
          style:
              Get.textTheme.bodyMedium!.copyWith(fontSize: 18.sp, height: 0.9),
        ),
      ),
    );
  }
}
