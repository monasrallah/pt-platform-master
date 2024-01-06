import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/contact_us_controller.dart';
import 'widget/send_page.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.contactUs.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: controller.color,
          ),
          CustomElevatedButton(
            height: 75.h,
            title: AppStrings.technicalSupport.tr,
            onTap: () {
              controller.titleController.clear();
              controller.desController.clear();
              Get.to(
                () => SendPage(
                  appBarTitle: AppStrings.technicalSupport.tr,
                  titleController: controller.titleController,
                  desController: controller.desController,
                  onTapSend: () => controller.technicalSupport(),
                  loading: controller.isLoading,
                ),
              );
            },
          ),
          30.verticalSpace,
          CustomElevatedButton(
            height: 75.h,
            title: AppStrings.submitFeedback.tr,
            onTap: () {
              controller.titleController.clear();
              controller.desController.clear();
              Get.to(
                () => SendPage(
                  appBarTitle: AppStrings.submitFeedback.tr,
                  titleController: controller.titleController,
                  desController: controller.desController,
                  onTapSend: () => controller.feedback(),
                  loading: controller.isLoading,
                ),
              );
            },
          ),
          300.verticalSpace,
        ],
      ),
    );
  }
}
