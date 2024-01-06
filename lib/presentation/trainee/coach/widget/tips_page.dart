import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../shop/widget/tips_card.dart';

class TipsPage extends GetView<CoachController> {
  const TipsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.tips.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(
          () => controller.isLoading
              ? SizedBox(
                  width: 1.sw,
                  height: 0.7.sh,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : controller.tips.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : SizedBox(
                      height: 1.sh,
                      width: 1.sw,
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.tips.length,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(end: 15.w),
                              child: TipsCard(
                                image: ImageAssets.bronze,
                                tip: controller.tips[index],
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.sw / 0.5.sh,
                            crossAxisCount: 2),
                      ),
                    ),
        ),
      ),
    );
  }
}
