import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/shimmer_widget.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'getx/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: ColorManager.darkBlack,
      body: SizedBox(
        height: 1.sh,
        child: Obx(
          () => Stack(
            children: [
              Positioned(
                  width: 1.sw,
                  height: 1.sh,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.grey.shade800.withOpacity(0.95),
                        BlendMode.modulate),
                    child: Image.asset(
                      ImageAssets.manBackground,
                      fit: BoxFit.cover,
                    ),
                  )),
              // const CustomBackButton(),
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
              PositionedDirectional(
                top: 180.h,
                start: 8.w,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsetsDirectional.only(start: 8.w),
                  child: RichText(
                    text: TextSpan(
                        text: AppStrings.iAmA.tr,
                        style:
                            Get.textTheme.bodyLarge!.copyWith(fontSize: 28.sp),
                        children: [
                          TextSpan(
                            text: "\n${controller.userType.value}",
                            style: Get.textTheme.bodyLarge!
                                .copyWith(fontSize: 45.sp),
                          )
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 30.h, end: 30.h, top: 300.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Text(
                          AppStrings.firstName.tr,
                          style: Get.textTheme.bodySmall!
                              .copyWith(fontSize: 17.sp),
                        ),
                      ),
                      Obx(
                        () => CustomTextField(
                          hint: "",
                          textInputType: TextInputType.text,
                          textEditingController: controller.firstName,
                          errorText: controller.isFirstNameValid.value
                              ? null
                              : AppStrings.validFullName.tr,
                        ),
                      ),
                      30.verticalSpace,
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Text(
                          AppStrings.lastName.tr,
                          style: Get.textTheme.bodySmall!
                              .copyWith(fontSize: 17.sp),
                        ),
                      ),
                      Obx(
                        () => CustomTextField(
                          hint: "",
                          textInputType: TextInputType.text,
                          textEditingController: controller.lastName,
                          errorText: controller.isLastNameValid.value
                              ? null
                              : AppStrings.validFullName.tr,
                        ),
                      ),
                      if (controller.userType.value == "Coach") ...[
                        30.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          child: Text(
                            AppStrings.mobileNumber.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 17.sp),
                          ),
                        ),
                        Obx(
                          () => CustomTextField(
                            isPhone: true,
                            hint: "",
                            showCountryFlag: false,
                            showDropdownIcon: true,
                            errorText: controller.isMobileValid.value
                                ? null
                                : AppStrings.validPhone.tr,
                            height: controller.isMobileValid.value ? null : 80,
                            onChanged: (phone) {
                              controller.isMobileValid.value = true;
                              controller.countryCode = phone.countryISOCode;
                            },
                            textInputType: TextInputType.phone,
                            contentPadding: EdgeInsetsDirectional.only(
                                start: controller.isMobileValid.value
                                    ? 150.w
                                    : 30.w),
                            textEditingController: controller.mobile,
                          ),
                        ),
                        30.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          child: Text(
                            AppStrings.categories.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 17.sp),
                          ),
                        ),
                        buildCategoryDropDown(),
                      ],
                      30.verticalSpace,
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Text(
                          AppStrings.password.tr,
                          style: Get.textTheme.bodySmall!
                              .copyWith(fontSize: 17.sp),
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
                      30.verticalSpace,
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Text(
                          AppStrings.passwordConfirm.tr,
                          style: Get.textTheme.bodySmall!
                              .copyWith(fontSize: 17.sp),
                        ),
                      ),
                      Obx(
                        () => CustomTextField(
                          hint: "",
                          textEditingController: controller.confirmPassword,
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
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
                      if (controller.userType.value == "Coach") ...[
                        30.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          child: Text(
                            AppStrings.socialMediaLink.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 17.sp),
                          ),
                        ),
                        Obx(
                          () => CustomTextField(
                            hint: "",
                            textInputType: TextInputType.url,
                            textEditingController: controller.socialMediaLink,
                            errorText: controller.isSocialMediaLinkValid.value
                                ? null
                                : AppStrings.validLink.tr,
                          ),
                        ),
                        30.verticalSpace,
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          child: Text(
                            AppStrings.potentialTrainees.tr,
                            style: Get.textTheme.bodySmall!
                                .copyWith(fontSize: 17.sp),
                          ),
                        ),
                        Obx(
                          () => CustomTextField(
                            hint: "",
                            textInputType: TextInputType.number,
                            textEditingController: controller.potentialClients,
                            errorText: controller.isPotentialClientsValid.value
                                ? null
                                : AppStrings.validNumber.tr,
                          ),
                        ),
                      ],

                      70.verticalSpace,
                      CustomElevatedButton(
                          title: AppStrings.next.tr,
                          onTap: () async {
                            await controller.register();
                            // Get.offAllNamed(Routes.categoryRoute);
                          }),
                      // const Spacer(),
                      50.verticalSpace,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDropDown() {
    return controller.isCategoryLoading
        ? ShimmerWidget.rounderRectangleBorder(
            width: 1.sw,
            height: 50.h,
            borderRadius: 22.r,
          )
        : DropdownSearch<String>.multiSelection(
            // asyncItems:  (String filter) => controller.getCategory(),
            items: controller.categories,
            autoValidateMode: AutovalidateMode.always,
            popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                showSearchBox: false,
                constraints: BoxConstraints(maxHeight: 350.h)),
            enabled: true,
            onChanged: (List<String> data) {
              // controller.category.text + "," + data;
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: Get.textTheme.displaySmall!.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              dropdownSearchDecoration: InputDecoration(
                // prefixIcon: prefixIcon,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                border: Get.theme.inputDecorationTheme.border,

                // enabled border
                enabledBorder: Get.theme.inputDecorationTheme.enabledBorder,

                // focused border
                focusedBorder: Get.theme.inputDecorationTheme.focusedBorder,

                // error border
                errorBorder: Get.theme.inputDecorationTheme.errorBorder,

                // focused error border
                focusedErrorBorder:
                    Get.theme.inputDecorationTheme.focusedErrorBorder,
              ),
            ),
          );
  }
}
