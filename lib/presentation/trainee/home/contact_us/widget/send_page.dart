import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class SendPage extends StatelessWidget {
  const SendPage({
    required this.appBarTitle,
    required this.titleController,
    required this.desController,
    required this.onTapSend,
    required this.loading,
    Key? key,
  }) : super(key: key);
  final String appBarTitle;
  final TextEditingController titleController;
  final TextEditingController desController;
  final Function onTapSend;
  final RxBool loading;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: appBarTitle),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            30.verticalSpace,
            Text(
              AppStrings.needHelpOrHaveQuestion.tr,
              style: Get.textTheme.bodyMedium,
            ),
            30.verticalSpace,
            CustomTextField(
              textEditingController: titleController,
              style: Get.textTheme.titleSmall,
              hint: AppStrings.title.tr,
              hintStyle: Get.textTheme.headlineSmall!.copyWith(fontSize: 17.sp),
              filled: true,
              fillColor: ColorManager.white,
              isUnderLineBorderStyle: true,
            ),
            12.verticalSpace,
            CustomTextField(
              textEditingController: desController,
              style: Get.textTheme.titleSmall,
              hint: AppStrings.message.tr,
              hintStyle: Get.textTheme.headlineSmall!.copyWith(fontSize: 17.sp),
              filled: true,
              maxLines: 10,
              contentPadding: EdgeInsetsDirectional.symmetric(
                  vertical: 10.h, horizontal: 20.w),
              fillColor: ColorManager.white,
              isUnderLineBorderStyle: true,
            ),
            50.verticalSpace,
            Obx(
              () => loading.value
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      height: 75.h,
                      title: "send".tr,
                      onTap: () => onTapSend(),
                    ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
