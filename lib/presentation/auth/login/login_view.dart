import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'getx/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  Widget buildBody() {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: 1.sh,
        child: Stack(
          children: [
            // const CustomBackButton(),
            Positioned(
                width: 1.sw,
                height: 1.sh,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.grey.shade800.withOpacity(0.85),
                      BlendMode.modulate),
                  child: Image.asset(
                    ImageAssets.womenBackground,
                    fit: BoxFit.cover,
                  ),
                )),
            // PositionedDirectional(
            //   top: 0.05.sh,
            //   start: 0.15.sw,
            //   child: SizedBox(
            //     height: 80,
            //     width: 300.w,
            //     child: SvgPicture.asset(
            //       IconsAssets.logo,
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    200.verticalSpace,
                    Container(
                      width: 1.sw,
                      padding: EdgeInsetsDirectional.only(start: 8.w),
                      child: Text(
                        AppStrings.signIn.tr,
                        style:
                            Get.textTheme.bodyLarge!.copyWith(fontSize: 45.sp),
                      ),
                    ),
                    70.verticalSpace,
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Text(
                        AppStrings.email.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                      ),
                    ),
                    Obx(
                      () => CustomTextField(
                        hint: "",
                        textInputType: TextInputType.emailAddress,
                        textEditingController: controller.email,
                        errorText: controller.isEmailValid.value
                            ? null
                            : AppStrings.validEmail.tr,
                      ),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Text(
                        AppStrings.password.tr,
                        style:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 17.sp),
                      ),
                    ),
                    Obx(
                      () => CustomTextField(
                        hint: "",
                        textEditingController: controller.password,
                        obscureText: !controller.isPasswordVisible.value,
                        errorText: controller.isPasswordValid.value
                            ? null
                            : AppStrings.validPassword.tr,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: InkWell(
                            onTap: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
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
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 18.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.forgetPasswordRoute,
                                arguments: controller.userType.value),
                            child: Text(
                              AppStrings.forgotYourPassword.tr,
                              style: Get.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    70.verticalSpace,
                    Obx(
                      () => controller.isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            )
                          : CustomElevatedButton(
                              title: AppStrings.login.tr,
                              width: 1.sw,
                              onTap: () async {
                                await controller.login();
                                // Get.offAllNamed(Routes.categoryRoute);
                              }),
                    ),
                    // const Spacer(),
                    20.verticalSpace,
                    GestureDetector(
                      onTap: () => controller.userType.value.contains("Trainee")
                          ? Get.toNamed(Routes.verifiedEmailRoute,
                              arguments: "Trainee")
                          : Get.toNamed(Routes.verifiedEmailRoute,
                              arguments: "Coach"),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            text: AppStrings.donHaveAnAccount.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 18.sp),
                            children: [
                              TextSpan(
                                text: AppStrings.signUpHere.tr,
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  fontSize: 18.sp,
                                  // decoration: TextDecoration.underline,
                                  // decorationColor: ColorManager.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
