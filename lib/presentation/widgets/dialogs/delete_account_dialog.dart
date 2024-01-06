import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../buttons/custom_elevated_button.dart';

class DeleteAccountDialog extends StatelessWidget {
  final Function toDo;
  final TextEditingController controller;

  const DeleteAccountDialog({
    super.key,
    required this.toDo,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.grey.shade700,
      title: Text(
        AppStrings.alert.tr,
        style: Get.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      titlePadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      content: SizedBox(
        height: 140.h,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.areYouSureYouWantToDeleteTheAccount.tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
            ),
            20.verticalSpace,
            CustomTextField(
              hint: AppStrings.enterYouPassword.tr,
              hintStyle: Get.textTheme.headlineSmall,
              // isUnderLineBorderStyle: true,
              style: Get.textTheme.titleSmall,
              textEditingController: controller,
              filled: true,
              fillColor: ColorManager.white24,
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: [
        Center(
          child: InkWell(
            onTap: () {
              toDo();
              Get.back();
            },
            child: Container(
              height: 60.h,
              width: 1.sw,
              padding: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.grey),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Text(
                AppStrings.ok.tr,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // CustomElevatedButton(
          //   height: 50.h,
          //   width: 200.w,
          //   title: AppStrings.apply.tr,
          //   textStyle: Get.textTheme.bodyMedium!
          //       .copyWith(height: 0.3, fontSize: 20.sp),
          //   onTap: () async {
          //     await toDo.call();
          //     Get.back();
          //   },
          // ),
        ),
      ],
    );
  }
}
