import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/recipes/widget/recipes_details_page.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/custom_video_player_widget.dart';
import '../../../../widgets/dialogs/view_image_dialog.dart';
import '../../../home/nutrition/recipes/getx/recipes_controller.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/personal_training_controller.dart';
import 'widget/open_file_page.dart';
import 'widget/personal_training_list_widget.dart';
import 'widget/personal_training_video_page.dart';
import 'widget/text_page.dart';

class PersonalTrainingView extends GetView<PersonalTrainingController> {
  const PersonalTrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: Obx(
        () => controller.selectHome.value
            ? buildHomeBody()
            : buildPersonalisedBody(),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.2.sh),
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
                        AppStrings.personalTraining.tr,
                        style: Get.textTheme.displayLarge!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 0.15.sh, start: 20.w, end: 20.w),
              child: SizedBox(
                height: 45.h,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSection(
                          title: AppStrings.home.tr,
                          color: controller.selectHome.value
                              ? ColorManager.primary
                              : Colors.transparent,
                          onTap: controller.onTapHomeSection),
                      buildSection(
                          title: AppStrings.personalised.tr,
                          color: !controller.selectHome.value
                              ? ColorManager.primary
                              : Colors.transparent,
                          onTap: controller.onTapPersonalisedSection),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomeBody() {
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
              : controller.meals.isEmpty && controller.workouts.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        if (controller.workouts.isNotEmpty) ...[
                          Text(
                            AppStrings.assignedWorkout.tr,
                            style: Get.textTheme.bodyLarge,
                          ),
                          10.verticalSpace,
                          SizedBox(
                            width: 1.sw,
                            height: 0.35.sh,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.workouts.length,
                              itemBuilder: (context, index) {
                                return PersonalTrainingWorkoutListWidget(
                                  personalTraining: controller.workouts[index],
                                  onTap: () {
                                    controller.getPersonalTrainingVideo(
                                        controller.workouts[index].id);
                                    return Get.to(
                                      () => const PersonalTrainingVideoPage(),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                        10.verticalSpace,
                        if (controller.meals.isNotEmpty) ...[
                          Text(
                            AppStrings.assignedMeals.tr,
                            style: Get.textTheme.bodyLarge,
                          ),
                          10.verticalSpace,
                          SizedBox(
                            width: 1.sw,
                            height: 0.35.sh,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.meals.length,
                              itemBuilder: (context, index) {
                                return PersonalTrainingMealsListWidget(
                                  recipeEntity: controller.meals[index],
                                  onTap: () {
                                    Get.lazyPut(() => RecipesController());
                                    String link = Get.find<AppController>()
                                        .getLinkInfo(
                                            index: index,
                                            htmlText: controller
                                                .meals[index].description);
                                    // controller.getPersonalTrainingVideo(controller.workouts[index].id);
                                    return Get.to(
                                      () => RecipesDetailsPage(
                                        recipe: controller.meals[index],
                                        link: link,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
        ),
      ),
    );
  }

  Widget buildPersonalisedBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
              : controller.personalized.video.isEmpty &&
                      controller.personalized.image.isEmpty &&
                      controller.personalized.pdf.isEmpty &&
                      controller.personalized.freeText.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.personalized.video.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              AppStrings.videos.tr,
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                          PersonalisedListWidget(
                            image: ImageAssets.videoPlaceHolder,
                            data: controller.personalized.video,
                            onTap: (index) {
                              Get.to(() => MyVideoPlayer(
                                    fullScreen: false,
                                    videoUrl: controller
                                        .personalized.video[index].value,
                                    onVideoChanged: (newVideoUrl) {
                                      // controller.videoUrl.value = controller
                                      //     .videos[controller.videoIndex.value].video;
                                    },
                                  ));
                            },
                          ),
                        ],
                        if (controller.personalized.image.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              AppStrings.image.tr,
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                          PersonalisedListWidget(
                            data: controller.personalized.image,
                            onTap: (index) => Get.dialog(
                              ViewImageDialog.funDialog(
                                  controller.personalized.image[index].value),
                            ),
                          ),
                        ],
                        if (controller.personalized.pdf.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              AppStrings.notes.tr,
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                          PersonalisedListWidget(
                            data: controller.personalized.pdf,
                            image: ImageAssets.pdf,
                            onTap: (index) {
                              Get.to(() => PDFScreen(
                                  pdfURL: controller
                                      .personalized.pdf[index].value));
                            },
                          ),
                        ],
                        if (controller.personalized.freeText.isNotEmpty) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              AppStrings.freeText.tr,
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                          PersonalisedListWidget(
                            data: controller.personalized.freeText,
                            image: ImageAssets.note,
                            onTap: (index) {
                              Get.to(() => TextPage(
                                  text: controller
                                      .personalized.freeText[index].value));
                            },
                          ),
                        ],
                        20.verticalSpace,
                      ],
                    ),
        ),
      ),
    );
  }

  Widget buildSection(
      {required String title, Color? color, required Function onTap}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            title,
            style:
                Get.textTheme.bodySmall!.copyWith(fontSize: 19.sp, height: 0.7),
          ),
        ),
      ),
    );
  }
}
