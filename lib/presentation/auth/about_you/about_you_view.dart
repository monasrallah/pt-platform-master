import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/auth/about_you/getx/about_you_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../app/dependency_injection.dart';
import '../../../app/storage/app_prefs.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import 'widget/about_you_card.dart';

class AboutYouView extends GetView<AboutYouController> {
  const AboutYouView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              width: 1.sw,
              height: 1.sh,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.grey.shade800.withOpacity(0.95), BlendMode.modulate),
                child: Image.asset(
                  ImageAssets.manBackground,
                  fit: BoxFit.cover,
                ),
              )),
          // const CustomBackButton(),
          PositionedDirectional(
            top: 0.05.sh,
            start: 0.15.sw,
            child: SizedBox(
              height: 80,
              width: 300.w,
              child: Image.asset(
                IconsAssets.logo,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                250.verticalSpace,
                Text(
                  AppStrings.tellUs.tr,
                  style: Get.textTheme.bodyMedium!.copyWith(fontSize: 25.sp),
                ),
                12.verticalSpace,
                Text(
                  AppStrings.aboutYou.tr,
                  style: Get.textTheme.bodyLarge!.copyWith(fontSize: 45.sp),
                ),
                40.verticalSpace,
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.tapTrainee(),
                          child: AboutYouCard(
                            title: AppStrings.iTrainee.tr,
                            selected: controller.selectedTrainee.value,
                          ),
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.tapCoach(),
                          child: AboutYouCard(
                            title: AppStrings.iCoach.tr,
                            selected: !controller.selectedTrainee.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
                CustomElevatedButton(
                  title: AppStrings.next.tr,
                  width: 1.sw,
                  onTap: () {
                    instance<AppPreferences>()
                        .setLoginUser(controller.selectedTrainee.value);
                    Get.toNamed(Routes.loginRoute,
                        arguments: controller.selectedTrainee.value
                            ? "Trainee"
                            : "Coach");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
