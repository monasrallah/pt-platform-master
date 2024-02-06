import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/exercises/getx/exercises_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/cards/image_card_horizon.dart';
import '../../../../widgets/custom_video_player_widget.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class ExercisesDetailsPage extends GetView<ExercisesController> {
  const ExercisesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: Obx(
          () => controller.isLoading ? const SizedBox.shrink() : buildBody()),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.38.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Obx(
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
                  ? Container()
                  : Stack(
                      children: [
                        100.verticalSpace,
                        PositionedDirectional(
                          top: 30.h,
                          child: Obx(
                            () => MyVideoPlayer(
                              fullScreen: false,
                              videoUrl: controller.videoUrl.value,
                              onVideoChanged: (newVideoUrl) {
                                controller.videoUrl.value = controller
                                    .videos[controller.videoIndex.value].video;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 0.33.sh, 15.w, 0),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.isButtonLoading
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CustomElevatedButton(
                                              title:
                                                  // controller.isFavourite.value
                                                  //     ? "Remove from favourites" :
                                                  AppStrings.addToFavourites.tr,
                                              padding: EdgeInsetsDirectional
                                                  .symmetric(horizontal: 5.w),
                                              textStyle: Get
                                                  .textTheme.bodySmall!
                                                  .copyWith(fontSize: 14.sp),
                                              maxLines: 2,
                                              onTap: () async {
                                                await controller
                                                    .addFavouriteVideo(
                                                        controller
                                                            .videos[controller
                                                                .videoIndex
                                                                .value]
                                                            .id);
                                              },
                                            ),
                                          ),
                                          6.horizontalSpace,
                                          Expanded(
                                            child: CustomElevatedButton(
                                              title:
                                                  // controller.isWorkout.value
                                                  //     ? "Remove today's workout" :
                                                  AppStrings.addTodayWorkout.tr,
                                              padding: EdgeInsetsDirectional
                                                  .symmetric(horizontal: 5.w),
                                              textStyle: Get
                                                  .textTheme.bodySmall!
                                                  .copyWith(fontSize: 14.sp),
                                              maxLines: 2,
                                              onTap: () async {

                                                await controller
                                                    .addTodayWorkOutVideo(
                                                        controller
                                                            .videos[controller
                                                                .videoIndex
                                                                .value]
                                                            .id);
                                              },
                                            ),
                                          ),
                                          6.horizontalSpace,
                                          Expanded(
                                            child: CustomElevatedButton(
                                                title: AppStrings.addToLog.tr,
                                                textStyle: Get
                                                    .textTheme.bodySmall!
                                                    .copyWith(fontSize: 14.sp),
                                                maxLines: 2,
                                                onTap: () {
                                                  controller.openLogDialog();
                                                }),
                                          ),
                                        ],
                                      ),
                                10.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 50.h,
                          start: 10.w,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: ColorManager.primary,
                                  size: 30.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
        child: controller.videos.isEmpty
            ? SizedBox(
                height: 0.2.sh,
                width: 1.sw,
                child: SvgPicture.asset(IconsAssets.noData),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller
                          .videos[controller.videoIndex.value].description,
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                    ),
                  ),
                  10.verticalSpace,
                  Text(controller.videos[controller.videoIndex.value].title),
                  ListView.builder(
                    itemCount: controller.videos.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ImageCardHorizon(
                        image: controller.videos[index].image,
                        title: controller.videos[index].title,
                        onTap: () {
                          controller.onSwitchAnotherVideo(index);
                        },
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
