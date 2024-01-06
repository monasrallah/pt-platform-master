import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/kyc_controller.dart';
import 'widget/question_widget.dart';

class KycView extends GetView<KycController> {
  const KycView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.questions.tr),
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
            Text(AppStrings.enterYourDetails.tr),
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
                  : controller.kyc.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
                          width: 1.sw,
                          child: SvgPicture.asset(IconsAssets.noData),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.kyc.length,
                          itemBuilder: (context, index) {
                            return QuestionWidget(
                              faqsEntity: controller.kyc[index].obs,
                              onSubmit: (value) {
                                controller.kyc[index] = FaqsEntity.copyWith(
                                    FaqsEntity(
                                        id: controller.kyc[index].id,
                                        question:
                                            controller.kyc[index].question,
                                        answer: value));
                              },
                            );
                          },
                        ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () async {
                  await controller.answerKyc();
                },
                child: Text(AppStrings.done.tr),
              ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }
}
