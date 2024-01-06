import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../buttons/custom_elevated_button.dart';

class UpdateProgressDialog extends StatelessWidget {
  const UpdateProgressDialog(
      {required this.header,
      this.width,
      this.height,
      required this.buttonTitle,
      required this.onTap,
      required this.listOfController,
      Key? key})
      : super(key: key);
  final double? width;
  final double? height;
  final String header;
  final String buttonTitle;
  final Function onTap;
  final List<TextEditingController> listOfController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      titlePadding: EdgeInsets.all(12.w),
      title: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.white,
              size: 30.w,
            ),
          ),
          20.horizontalSpace,
          Text(
            header,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Get.context!.textTheme.bodyLarge?.copyWith(fontSize: 22.sp),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: width ?? 0.7.sw,
          height: height ?? 500.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                textEditingController: listOfController[0],
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.weight.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                textEditingController: listOfController[1],
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.muscle.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                textEditingController: listOfController[2],
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.fat.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                textEditingController: listOfController[3],
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.water.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                textEditingController: listOfController[4],
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.activeCalories.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              10.verticalSpace,
              CustomTextField(
                hint: "",
                textInputType: TextInputType.number,
                textEditingController: listOfController[5],
                color: ColorManager.white,
                cursorColor: ColorManager.white,
                prefix: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.w),
                  child: Text(
                    "${AppStrings.steps.tr} : ",
                    style: Get.textTheme.bodySmall!.copyWith(height: 3),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: CustomElevatedButton(
                  title: buttonTitle,
                  textStyle: Get.textTheme.displayMedium,
                  width: 150,
                  backgroundColor: ColorManager.white,
                  onTap: () => onTap(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
