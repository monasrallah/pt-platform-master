import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../resources/assets_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../../widgets/custom_expantion_tile_widget.dart';
import '../../../widgets/custom_video_player_widget.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/faqs_controller.dart';

class FAQsView extends GetView<FAQsController> {
  const FAQsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.fAQs.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: const SizedBox.shrink(),
          ),
          20.verticalSpace,
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
                : controller.faqs.isEmpty
                    ? SizedBox(
                        height: 0.7.sh,
                        width: 1.sw,
                        child: SvgPicture.asset(IconsAssets.noData),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.faqs.length,
                        itemBuilder: (context, index) {
                          return CustomExpansionTile(
                            expandedItem: controller.expanded,
                            key: Key(index.toString()),
                            title: Padding(
                              padding: EdgeInsetsDirectional.only(start: 5.w),
                              child: SizedBox(
                                  width: 0.7.sw,
                                  child: Text(
                                    controller.faqs[index].question,
                                    textAlign: TextAlign.start,
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(fontSize: 20.sp),
                                  )),
                            ),
                            trailing: const Icon(Icons.arrow_drop_down_sharp),
                            children: <Widget>[
                              controller.faqs[index].video != null
                                  ? MyVideoPlayer(
                                      fullScreen: false,
                                      videoUrl: controller.faqs[index].video!,
                                      onVideoChanged: (value) {},
                                    )
                                  : Container(),
                              12.verticalSpace,
                              Text(
                                controller.faqs[index].answer,
                                style: Get.textTheme.bodySmall!
                                    .copyWith(fontSize: 18.sp),
                              ),
                            ],
                          );
                          // return CustomExpansionTileWidget(
                          //   title: SizedBox(
                          //       width: 0.7.sw,
                          //       child: Text(
                          //         'do u prefer to make supplement?',
                          //         style:
                          //             Get.textTheme.titleMedium!.copyWith(fontSize: 20.sp),
                          //       )),
                          //   children: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const MyVideoPlayer(fullScreen: false),
                          //       12.verticalSpace,
                          //       Text(
                          //         'no I do not :)',
                          //         style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
