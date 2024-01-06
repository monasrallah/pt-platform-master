import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/routes_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../resources/design_constants.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/dialogs/delete_account_dialog.dart';
import '../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Get.find<AppController>().openConfirmationDialog();
      },
      child: MainBottomNavigationBar(
        appBarWidget: buildAppBar(),
        bodyWidget: buildBody(context),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.1.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.verticalSpace,
              Text(
                AppStrings.profile.tr,
                style: Get.textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                print(controller.isFileProductImage.value);
                print(controller.profile.value.avatar);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    30.horizontalSpace,
                    controller.isFileProductImage.value
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CustomImage(
                              height: 130.h,
                              width: 130.h,
                              color: ColorManager.grey.withOpacity(0.9),
                              borderColor: Get.theme.cardColor,
                              shape: BoxShape.rectangle,
                              borderWidth: 1.0,
                              boxFit: BoxFit.contain,
                              isFileImage: true,
                              imagePath: controller.productImageFile.value.path,
                            ),
                          )
                        : Container(
                            height: 130.h,
                            width: 130.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                  color: ColorManager.primary, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.network(
                                controller.profile.value.avatar != null
                                    ? controller.profile.value.avatar!
                                    : Get.find<AppController>().defaultImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    // Container(
                    //   height: 130.h,
                    //   width: 130.h,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(100.r),
                    //     border: Border.all(color: ColorManager.primary, width: 3),
                    //   ),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(100.r),
                    //     child: Image.asset(
                    //       ImageAssets.coaches,
                    //     ),
                    //   ),
                    // ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: () => controller.isFileProductImage.value
                          ? controller.editImage()
                          : controller.openSelectProductImageDialog(),
                      child: Icon(
                        controller.isFileProductImage.value
                            ? Icons.check
                            : Icons.edit,
                        color: ColorManager.primary,
                        size: 30.w,
                      ),
                    ),
                  ],
                );
              },
            ),
            30.verticalSpace,
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.horizontalSpace,
                  SizedBox(
                    width: 0.6.sw,
                    child: Obx(
                      () => controller.isLoading
                          ? ShimmerWidget.rectangular(
                              height: 40.h,
                              borderRadius: 30.r,
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      // FocusScope.of(context).unfocus();
                                    },
                                    readOnly: controller.readOnly.value,
                                    textAlign: TextAlign.end,
                                    controller: controller.firstNameController,
                                    style: Get.textTheme.bodyLarge,
                                    decoration: InputDecoration(
                                      border: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      enabledBorder: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      focusedBorder: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7.w),
                                Expanded(
                                  child: TextField(
                                    readOnly: controller.readOnly.value,
                                    textAlign: TextAlign.start,
                                    controller: controller.lastNameController,
                                    style: Get.textTheme.bodyLarge,
                                    decoration: InputDecoration(
                                      border: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      enabledBorder: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      focusedBorder: controller.readOnly.value
                                          ? kUnderlinedBorderTransparent
                                          : kUnderlinedBorderGrey,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.readOnly.value = !controller.readOnly.value;
                      if (controller.readOnly.value) controller.editName();
                    },
                    child: Icon(
                      controller.readOnly.value ? Icons.edit : Icons.check,
                      color: ColorManager.primary,
                      size: 30.w,
                    ),
                  ),
                  30.horizontalSpace,
                ],
              ),
            ),
            30.verticalSpace,
            Obx(
              () => controller.isLoading
                  ? ShimmerWidget.rectangular(
                      height: 40.h,
                      borderRadius: 30.r,
                    )
                  : Text(
                      controller.profile.value.email,
                      style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                    ),
            ),
            30.verticalSpace,
            buildRow(
              title: AppStrings.assignedCoaches.tr,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.primary,
                size: 30.w,
              ),
              onTap: () {
                Get.toNamed(Routes.assignedCoachesRoute);
              },
            ),
            buildRow(
              title: AppStrings.settings.tr,
              onTap: () {
                Get.toNamed(Routes.settingRoute);
              },
            ),
            buildRow(
              title: AppStrings.deleteMyAccount.tr,
              onTap: () {
                Get.dialog(DeleteAccountDialog(
                  toDo: () async {
                    await controller.deleteAccount();
                  },
                  controller: controller.passwordController,
                ));
              },
            ),
            Obx(
              () => controller.isLogoutLoading
                  ? Padding(
                      padding: EdgeInsets.only(top: 22.h),
                      child: const CircularProgressIndicator(),
                    )
                  : buildRow(
                      title: AppStrings.logout.tr,
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30.w,
                      ),
                      onTap: () async {
                        await controller.logout();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
      {required String title, Widget? icon, required Function onTap}) {
    return Column(
      children: [
        Container(
          height: 0.5,
          width: 1.sw,
          color: ColorManager.white,
        ),
        InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  title,
                  style: Get.textTheme.bodyMedium!.copyWith(fontSize: 22.sp),
                ),
                const Spacer(),
                icon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: 1.sw,
          color: ColorManager.white,
        ),
      ],
    );
  }
}
