import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../getx/challenge_controller.dart';
import 'challenge_video_page.dart';

class ChallengeCoachDetailsPage extends GetView<ChallengeCoachController> {
  const ChallengeCoachDetailsPage({required this.challenge, Key? key})
      : super(key: key);

  final ChallengeEntity challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBackBar(title: AppStrings.challenges.tr),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Obx(
              () => Text(
                  "${controller.challengeAcceptedId.length}-${controller.videos.length} Challenged Complete"),
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
                  : controller.videos.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
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
                                Get.to(
                                  () => const ChallengeCoachVideoPage(),
                                );
                              },
                              child: buildContainerChallenge(
                                  image: controller.videos[index].video.image,
                                  title: controller.videos[index].video.title,
                                  id: controller.videos[index].id,
                                  check:
                                      controller.videos[index].isComplete.obs),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.sw / 0.75.sh,
                                  crossAxisCount: 2),
                        ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget buildContainerChallenge(
      {required String image,
      required String title,
      required int id,
      required RxBool check}) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 230.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            15.verticalSpace,
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
