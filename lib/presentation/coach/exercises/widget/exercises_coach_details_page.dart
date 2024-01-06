import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../widgets/cards/image_card_horizon.dart';
import '../../../widgets/custom_video_player_widget.dart';
import '../getx/exercises_controller.dart';

class ExercisesCoachDetailsPage extends GetView<ExercisesCoachController> {
  const ExercisesCoachDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Obx(() => controller.isLoading
          ? const CircularProgressIndicator()
          : buildBody()),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.3.sh),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.verticalSpace,
                            ],
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
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.videos[controller.videoIndex.value].description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
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
