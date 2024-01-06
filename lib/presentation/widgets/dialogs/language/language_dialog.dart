import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/language_manger.dart';
import '../../../../resources/strings_manager.dart';
import '../../buttons/custom_elevated_button.dart';
import 'language_controller.dart';

class LanguageDialog extends GetView<LanguageController> {
  final Function toDo;

  const LanguageDialog({
    super.key,
    required this.toDo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.grey.shade700,
      iconPadding: EdgeInsets.fromLTRB(0.w, 12.h, 10.w, 0),
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.clear,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      contentPadding: EdgeInsets.only(bottom: 20.h),
      content: SizedBox(
        height: 190.h,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.selectLanguage.tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium!.copyWith(fontSize: 23.sp),
            ),
            20.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(left: 120.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildLangTile(selected: controller.english, title: 'English'),
                  8.verticalSpace,
                  buildLangTile(selected: controller.arabic, title: 'Arabic'),
                ],
              ),
            ),
            20.verticalSpace,
            Center(
              child: CustomElevatedButton(
                height: 50.h,
                width: 200.w,
                title: AppStrings.apply.tr,
                textStyle: Get.textTheme.bodyMedium!
                    .copyWith(height: 0.3, fontSize: 20.sp),
                onTap: () async {
                  await toDo.call();
                  LocalizationService.changeLocale(
                      controller.english.value ? "en" : "ar");
                  instance<AppPreferences>()
                      .setAppLanguage(controller.english.value ? "en" : "ar");
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLangTile({required RxBool selected, required String title}) {
    return Obx(
          () =>
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () =>
                    controller.changeLanguage(isEnglish: title == "English"),
                child: Container(
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    border: Border.all(color: ColorManager.primary),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Container(
                    height: 17.h,
                    width: 17.h,
                    margin: EdgeInsets.all(1.h),
                    decoration: BoxDecoration(
                      color: selected.value
                          ? ColorManager.primary
                          : ColorManager.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ),
              ),
              8.horizontalSpace,
              InkWell(
                onTap: () =>
                    controller.changeLanguage(isEnglish: title == "English"),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
                ),
              ),
            ],
          ),
    );
  }
}
