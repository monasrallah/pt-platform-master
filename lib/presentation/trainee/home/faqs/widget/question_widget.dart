import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({Key? key, required this.question, required this.answer})
      : super(key: key);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
          ),
          15.verticalSpace,
          CustomTextField(
            hint: "",
            style: Get.textTheme.bodySmall,
            textEditingController: TextEditingController(text: answer),
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
