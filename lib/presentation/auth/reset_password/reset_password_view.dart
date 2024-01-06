import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'getx/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: Stack(
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
              ),
            ),
            PositionedDirectional(
              top: 0.06.sh,
              start: 0.05.sw,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
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
              padding: EdgeInsetsDirectional.symmetric(horizontal: 25.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    250.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsetsDirectional.only(start: 8.w),
                      child: Text(
                        AppStrings.resetNewPassword.tr,
                        style:
                            Get.textTheme.bodyLarge!.copyWith(fontSize: 26.sp),
                      ),
                    ),
                    50.verticalSpace,
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Text(
                        AppStrings.newPassword.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                      ),
                    ),
                    Obx(
                      () => CustomTextField(
                        hint: "",
                        color: ColorManager.grey,
                        textEditingController: controller.password,
                        obscureText: !controller.isPasswordVisible.value,
                        errorText: controller.isPasswordValid.value
                            ? null
                            : AppStrings.validPassword.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: InkWell(
                            onTap: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorManager.white,
                                size: 22.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Text(
                        AppStrings.confirmNewPassword.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                      ),
                    ),
                    Obx(
                      () => CustomTextField(
                        hint: "",
                        textEditingController: controller.confirmPassword,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        errorText: controller.isConfirmPasswordValid.value
                            ? null
                            : AppStrings.validConfirmPassword.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: InkWell(
                            onTap: () {
                              controller.isConfirmPasswordVisible.value =
                                  !controller.isConfirmPasswordVisible.value;
                            },
                            child: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: ColorManager.white,
                              size: 22.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    200.verticalSpace,
                    Obx(
                      () => controller.isLoading
                          ? SizedBox(
                              width: 1.sw,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            )
                          : CustomElevatedButton(
                              title: AppStrings.done.tr,
                              // backgroundColor: ColorManager.black,
                              onTap: () async {
                                await controller.reset();
                                // Get.offAll(() => const SuccessfulView());
                              },
                            ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
