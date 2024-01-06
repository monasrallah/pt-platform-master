import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/today_work_out/getx/today_work_out_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/today_work_out_video_page.dart';
import 'widget/today_work_out_card.dart';

class TodayWorkOutView extends GetView<TodayWorkOutController> {
  const TodayWorkOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.todayWorkout.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getTodayWorksOut();
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
                    : controller.videos.isEmpty
                        ? SizedBox(
                            height: 0.5.sh,
                            width: 1.sw,
                            child: SvgPicture.asset(IconsAssets.noData),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.videos.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.videoIndex.value = index;
                                  controller.videoUrl.value = controller
                                      .videos[controller.videoIndex.value]
                                      .video;
                                  Get.to(
                                    () => TodayWorkOutVideoPage(
                                      todayWorkOut: controller.videos[index],
                                    ),
                                  );
                                },
                                child: TodayWorkOutCard(
                                  title: controller.videos[index].title,
                                  image: controller.videos[index].image,
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
