import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'getx/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Colors.grey.shade800.withOpacity(0.95),
                      BlendMode.modulate),
                  child: Image.asset(
                    ImageAssets.womenBackground,
                    fit: BoxFit.cover,
                  ),
                )),
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
                        AppStrings.enterEmail.tr,
                        style:
                            Get.textTheme.bodyLarge!.copyWith(fontSize: 26.sp),
                      ),
                    ),
                    50.verticalSpace,
                    Obx(
                      () => CustomTextField(
                        hint: "",
                        color: ColorManager.grey,
                        textEditingController: controller.email,
                        errorText: controller.isEmailValid.value
                            ? null
                            : AppStrings.validEmail.tr,
                      ),
                    ),
                    200.verticalSpace,
                    Obx(
                      () => controller.isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            )
                          : CustomElevatedButton(
                              title: AppStrings.next.tr,
                              width: 1.sw,
                              onTap: () async {
                                await controller.sendEmailForget();
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
