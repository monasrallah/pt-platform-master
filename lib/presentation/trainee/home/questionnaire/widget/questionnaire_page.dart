import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../coach/kyc/widget/question_widget.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../getx/questionnaire_controller.dart';

class QuestionnaireView extends GetView<QuestionnaireController> {
  const QuestionnaireView({required this.index, Key? key}) : super(key: key);
  final int index;

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
                  : controller.questionnaire[index].questions.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
                          width: 1.sw,
                          child: SvgPicture.asset(IconsAssets.noData),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              controller.questionnaire[index].questions.length,
                          itemBuilder: (context, indexQu) {
                            return QuestionWidget(
                              faqsEntity: controller
                                  .questionnaire[index].questions[indexQu].obs,
                              onSubmit: (value) {
                                controller.questionnaire[index]
                                    .questions[indexQu] = FaqsEntity.copyWith(
                                  FaqsEntity(
                                      id: controller.questionnaire[index]
                                          .questions[indexQu].id,
                                      question: controller.questionnaire[index]
                                          .questions[indexQu].question,
                                      answer: value),
                                );
                              },
                            );
                          },
                        ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () async {
                  await controller.answerQuestionnaire(index);
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
