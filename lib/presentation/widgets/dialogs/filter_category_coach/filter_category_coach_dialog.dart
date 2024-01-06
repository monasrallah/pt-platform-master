import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/entities/auth_entities/category_entity.dart';
import 'package:pt_platform/presentation/widgets/dialogs/filter_category_coach/filter_category_coach_controller.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../buttons/custom_elevated_button.dart';

class FilterCategoryCoachDialog extends GetView<FilterCategoryCoachController> {
  const FilterCategoryCoachDialog(
      {required this.header,
      this.width,
      this.height,
      required this.buttonTitle,
      required this.categories,
      required this.onTapButton,
      Key? key})
      : super(key: key);
  final double? width;
  final double? height;
  final String header;
  final String buttonTitle;
  final List<CategoryEntity> categories;
  final Function(List<int>) onTapButton;

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
      contentPadding: EdgeInsets.symmetric(horizontal: 22.w),
      content: SizedBox(
        width: width ?? 0.7.sw,
        height: height ?? 350.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height ?? 260.h,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => InkWell(
                      onTap: () {
                        !controller.chosenCategory
                                .contains(categories[index].id)
                            ? controller.chosenCategory
                                .add(categories[index].id)
                            : controller.chosenCategory
                                .remove(categories[index].id);
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 22.w, bottom: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: (controller.chosenCategory
                                      .contains(categories[index].id))
                                  ? Icon(
                                      Icons.check,
                                      color: ColorManager.black,
                                    )
                                  : null,
                            ),
                            12.horizontalSpace,
                            Text(
                              categories[index].name,
                              style: Get.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Center(
              child: CustomElevatedButton(
                title: buttonTitle,
                textStyle: Get.textTheme.displayMedium,
                width: 150,
                backgroundColor: ColorManager.white,
                onTap: () => onTapButton(controller.chosenCategory),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
