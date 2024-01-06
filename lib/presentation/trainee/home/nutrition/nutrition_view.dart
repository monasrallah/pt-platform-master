import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/cards/coach_image_card.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/nutrition_controller.dart';

class NutritionView extends GetView<NutritionController> {
  const NutritionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      // appBarWidget: appBackBar(title: 'Nutrition'),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Image.asset(
            ImageAssets.darkBackground,
            fit: BoxFit.fitHeight,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 0.5.sh,
              alignment: Alignment.center,
              padding: EdgeInsets.all(25.h),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.gridImageList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => controller.gridOnTapList[index](),
                    child: CoachImageCard(
                      image: controller.gridImageList[index],
                      title: controller.gridTileList[index],
                      titleStyle:
                          Get.textTheme.displaySmall!.copyWith(fontSize: 15.sp),
                      onTap: () {},
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.sw / 0.5.sh,
                    crossAxisCount: 2),
              ),
            ),
          ],
        ),
        Container(
          height: 100.h,
          width: 1.sw,
          padding: EdgeInsetsDirectional.only(top: 40.h, start: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back,
                  color: ColorManager.primary,
                  size: 30.w,
                ),
              ),
              40.horizontalSpace,
              Text(
                AppStrings.nutrition.tr,
                style: Get.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
