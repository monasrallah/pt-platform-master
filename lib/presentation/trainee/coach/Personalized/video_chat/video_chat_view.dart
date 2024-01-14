import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/dialogs/confirm_choice_dialog.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/video_chat_controller.dart';
import 'widget/video_info_row.dart';

class VideoChatView extends GetView<VideoChatController> {
  const VideoChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: buildBody(),
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
                        AppStrings.videoChat.tr,
                        style: Get.textTheme.displayLarge!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 0.17.sh,
              start: 30,
              child: Text(
                AppStrings.bookedSessions.tr,
                style: Get.textTheme.bodyMedium!.copyWith(fontSize: 25.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Obx(
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
          : controller.chats.isEmpty
              ? SizedBox(
                  height: 0.7.sh,
                  width: 1.sw,
                  child: SvgPicture.asset(IconsAssets.noData),
                )
              : ListView.builder(
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    return VideoInfoRow(
                      chat: controller.chats[index],
                      onTapJoin: () {
                        launchUrl(Uri.parse(controller
                            .chats[index].coachTimeReservation.zoom.data.joinUrl
                            .toString()));
                      },
                      onTapCancel: () async {
                        Get.dialog(ConfirmChoiceDialog(
                          title: AppStrings.cancelVideoChat.tr,
                          message: AppStrings.confirmCancelVideoChat.tr,
                          toDoButton: AppStrings.ok.tr,
                          toDo: () async {
                            await controller
                                .deleteVideoChat(controller.chats[index].id);
                            controller.getVideoChat();
                          },
                        ));
                      },
                    );
                  },
                ),
    );
  }
}
