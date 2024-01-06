import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/favorites/getx/favorites_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/favorite_video_page.dart';
import 'widget/favorites_card.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.favorites.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getFavorite();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
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
                    : controller.favorites.isEmpty
                        ? SizedBox(
                            height: 0.7.sh,
                            width: 1.sw,
                            child: SvgPicture.asset(IconsAssets.noData),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.favorites.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.isFavourite.value =
                                      controller.favorites[index].isFavourite;
                                  controller.isWorkout.value =
                                      controller.favorites[index].isWorkout;
                                  controller.isTodayLog.value =
                                      controller.favorites[index].isTodayLog;
                                  controller.videoUrl.value =
                                      controller.favorites[index].video;
                                  controller.videoIndex.value = index;
                                  Get.to(
                                    () => FavoriteVideoPage(
                                      favorite: controller.favorites[index],
                                    ),
                                  );
                                },
                                child: FavoritesCard(
                                  title: controller.favorites[index].title,
                                  image: controller.favorites[index].image,
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.sw / 0.5.sh,
                                    crossAxisCount: 2),
                          ),
              ),
              300.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
