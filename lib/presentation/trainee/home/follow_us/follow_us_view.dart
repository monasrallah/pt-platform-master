import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/follow_us/getx/follow_us_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/follow_us_card.dart';

class FollowUsView extends GetView<FollowUsController> {
  const FollowUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.followUs.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async =>
              await controller.launchFacebook(controller.facebookUrl),
          child: FollowUsCard(
            title: AppStrings.pTPlatform,
            iconImage: IconsAssets.facebook,
          ),
        ),
        GestureDetector(
          onTap: () async =>
              await controller.launchFacebook(controller.instagramUrl),
          child: FollowUsCard(
            title: AppStrings.pTPlatform,
            iconImage: IconsAssets.instagram,
          ),
        ),
        300.verticalSpace,
      ],
    );
  }
}
