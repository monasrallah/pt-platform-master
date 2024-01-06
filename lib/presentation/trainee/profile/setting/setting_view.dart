import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/profile/setting/getx/setting_controller.dart';
import 'package:pt_platform/presentation/widgets/dialogs/language/language_controller.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../../widgets/dialogs/language/language_dialog.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/terms_condition_page.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.settings.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            50.verticalSpace,
            buildRow(
              title: AppStrings.pushNotifications.tr,
              verticalPadding: 5,
              icon: Obx(
                () => controller.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : Switch.adaptive(
                        value:  controller.pushNotification.value  ,
                        onChanged: (value) async {
                          await controller
                              .notification(!controller.pushNotification.value);
                        },
                      ),
              ),
              onTap: () {},
            ),
            buildRow(
              title: AppStrings.termsConditions.tr,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.primary,
                size: 30.w,
              ),
              onTap: () {
                Get.to(const WebViewApp());
              },
            ),
            buildRow(
              title: AppStrings.language.tr,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.primary,
                size: 30.w,
              ),
              onTap: () {
                Get.lazyPut(() => LanguageController());
                Get.dialog(
                  LanguageDialog(
                    toDo: () {},
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(
      {required String title,
      Widget? icon,
      required Function onTap,
      double? verticalPadding}) {
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
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding ?? 20.h, horizontal: 20.w),
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
