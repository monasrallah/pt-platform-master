import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../domain/entities/home_entities/faqs_entity.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({Key? key, required this.faqsEntity, required this.onSubmit})
      : super(key: key);

  final Rx<FaqsEntity> faqsEntity;
  final Function onSubmit;
  final TextEditingController answer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    answer.text = faqsEntity.value.answer;
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
          CustomTextField(
            hint: "",
            style: Get.textTheme.bodySmall,
            textEditingController: answer,
            onChanged: (value) {
              faqsEntity.update((val) {
                val!.answer = value;
              });
            },
            // onSubmit: (value) {
            //   onSubmit(value);
            // },
            // onTapOutside: () {
           
            //   onSubmit(answer.text);
            // },
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
