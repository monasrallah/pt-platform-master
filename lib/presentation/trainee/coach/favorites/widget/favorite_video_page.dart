import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/entities/coach_entities/video_entity.dart';
import 'package:pt_platform/presentation/trainee/coach/favorites/getx/favorites_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/cards/image_card_horizon.dart';
import '../../../../widgets/custom_video_player_widget.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class FavoriteVideoPage extends GetView<FavoritesController> {
  const FavoriteVideoPage({required this.favorite, Key? key}) : super(key: key);

  final VideoEntity favorite;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return await controller.getFavorite();
      },
      child: MainBottomNavigationBar(
        appBarWidget: buildAppBar(),
        bodyWidget: buildBody(),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.38.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            100.verticalSpace,
            PositionedDirectional(
              top: 30.h,
              child: Obx(
                () => MyVideoPlayer(
                  fullScreen: false,
                  videoUrl: controller.videoUrl.value,
                  onVideoChanged: (newVideoUrl) {
                    controller.videoUrl.value =
                        controller.favorites[controller.videoIndex.value].video;
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.w, 0.32.sh, 15.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.isButtonLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 5.w),
                                  textStyle: Get.textTheme.bodySmall!
                                      .copyWith(fontSize: 14.sp),
                                  maxLines: 2,
                                  onTap: () async {
                                    await controller
                                        .addFavouriteVideo(favorite.id);
                                  },
                                ),
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: CustomElevatedButton(
                                  title:
                                      // controller.isWorkout.value
                                      //     ? "Remove today's PersonalTraining" :
                                      AppStrings.addTodayWorkout.tr,
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 5.w),
                                  textStyle: Get.textTheme.bodySmall!
                                      .copyWith(fontSize: 14.sp),
                                  maxLines: 2,
                                  onTap: () async {
                                    await controller
                                        .addTodayWorkOutVideo(favorite.id);
                                  },
                                ),
                              ),
                              6.horizontalSpace,
                              Expanded(
                                child: CustomElevatedButton(
                                    title: AppStrings.addToLog.tr,
                                    textStyle: Get.textTheme.bodySmall!
                                        .copyWith(fontSize: 14.sp),
                                    maxLines: 2,
                                    onTap: () {
                                      print(controller.numberOfSet.value);
                                      controller.openLogDialog();
                                    }),
                              ),
                            ],
                          ),
                  ),
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
                    onTap: () async {
                      Get.back();
                      return await controller.getFavorite();
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
                controller.favorites[controller.videoIndex.value].description,
                style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
              ),
            ),
            10.verticalSpace,
            Obx(() =>
                Text(controller.favorites[controller.videoIndex.value].title)),
            ListView.builder(
              itemCount: controller.favorites.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ImageCardHorizon(
                  image: controller.favorites[index].image,
                  title: controller.favorites[index].title,
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
