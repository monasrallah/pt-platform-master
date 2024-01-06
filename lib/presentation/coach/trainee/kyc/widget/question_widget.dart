import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../domain/entities/home_entities/faqs_entity.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, required this.faqsEntity}) : super(key: key);

  final Rx<FaqsEntity> faqsEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            faqsEntity.value.question,
            style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
          15.verticalSpace,
          Text(
            style: Get.textTheme.bodySmall,
            faqsEntity.value.answer,
          ),
          20.verticalSpace,
          Container(
            height: 1,
            width: 1.sw,
            color: ColorManager.white,
          ),
        ],
      ),
    );
  }
}
