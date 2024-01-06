import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/questionnaire_controller.dart';
import 'widget/questionnaire_page.dart';

class SurveyView extends GetView<QuestionnaireController> {
  const SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.questionnaire.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  : controller.questionnaire.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
                          width: 1.sw,
                          child: SvgPicture.asset(IconsAssets.noData),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.questionnaire.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: CustomElevatedButton(
                                  title: controller
                                      .questionnaire[index].description,
                                  onTap: () => Get.to(
                                      () => QuestionnaireView(index: index))),
                            );
                          },
                        ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
