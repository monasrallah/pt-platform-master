import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../resources/strings_manager.dart';
import 'getx/challenge_controller.dart';
import 'widget/challenge_card.dart';
import 'widget/challenge_details_page.dart';

class ChallengeCoachView extends GetView<ChallengeCoachController> {
  const ChallengeCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
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
                  Colors.grey.shade800.withOpacity(0.5),
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
                        AppStrings.challenges.tr,
                        style: Get.textTheme.displayLarge!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(15.w, 0.12.sh, 0.5.sw, 0.h),
              child: Text(
                AppStrings.challengeOfTheDay.tr,
                style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
              ),
            )
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
          : controller.challenges.isEmpty
              ? SizedBox(
                  height: 0.7.sh,
                  width: 1.sw,
                  child: SvgPicture.asset(IconsAssets.noData),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.challenges.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Get.to(
                          () => ChallengeCoachDetailsPage(
                            challenge: controller.challenges[index],
                          ),
                        );
                        await controller.videoChallenges(
                            controller.challenges[index].id.toString());
                      },
                      child: ChallengeCoachCard(
                        imagePath: controller.challenges[index].icon,
                        day: controller.challenges[index].title,
                        description: controller.challenges[index].description,
                      ),
                    );
                  },
                ),
    );
  }
}
