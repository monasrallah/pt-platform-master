import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/entities/coach_entities/video_entity.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../widgets/cards/image_card_horizon.dart';
import '../../../../widgets/custom_video_player_widget.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../getx/today_work_out_controller.dart';

class TodayWorkOutVideoPage extends GetView<TodayWorkOutController> {
  const TodayWorkOutVideoPage({required this.todayWorkOut, Key? key})
      : super(key: key);

  final VideoEntity todayWorkOut;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return await controller.getTodayWorksOut();
      },
      child: MainBottomNavigationBar(
        appBarWidget: buildAppBar(),
        bodyWidget: Obx(() => controller.isLoading
            ? const CircularProgressIndicator()
            : buildBody()),
      ),
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
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
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
                              15.w, 0.31.sh, 15.w, 0),
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
                                                  // controller.isFavourite.value ?
                                                  // "Remove from favourites" :
                                                  "Add to favourites",
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
                                                  "Add today's workout",
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
                                                title: "Add to log",
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
                                onTap: () async {
                                  Get.back();
                                  return await controller.getTodayWorksOut();
                                },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                controller.videos[controller.videoIndex.value].description,
                style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
              ),
            ),
            10.verticalSpace,
            Text(controller.videos[controller.videoIndex.value].title),
            controller.videos.isEmpty
                ? Container()
                : ListView.builder(
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
