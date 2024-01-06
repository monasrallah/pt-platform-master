import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/profile/assigned_coach/getx/assigned_coach_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../app/app_controller.dart';
import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/assigned_coach_card.dart';

class AssignedCoachView extends GetView<AssignedCoachController> {
  const AssignedCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.assignedCoaches.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.verticalSpace,
              controller.isLoading
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
                  : controller.coaches.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
                          width: 1.sw,
                          child: SvgPicture.asset(IconsAssets.noData),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.coaches.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                instance<AppPreferences>().setCoachEntity([
                                  controller.coaches[index].id.toString(),
                                  controller.coaches[index].lastName.toString(),
                                  controller.coaches[index].avatar.toString(),
                                ]);
                                Get.find<AppController>().onItemTapped(1);
                              },
                              child: AssignedCoachCard(
                                title:
                                    "${controller.coaches[index].lastName}",
                                image: controller.coaches[index].avatar != null
                                    ? controller.coaches[index].avatar!
                                    : Get.find<AppController>().defaultImage,
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.sw / 0.75.sh,
                                  crossAxisCount: 2),
                        ),
              300.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
