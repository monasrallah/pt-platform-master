import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/routes_manager.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/dialogs/filter_category_coach/filter_category_coach_dialog.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/trainer_controller.dart';
import 'widget/trainer_card.dart';

class TrainerView extends GetView<TrainerController> {
  const TrainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.26.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // height: 0.35.sh,
              width: 1.sw,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade600.withOpacity(0.5),
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  ImageAssets.backAppBar,
                  // height: 0.40.sh,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          AppStrings.chooseYourCoach.tr,
                          style: Get.textTheme.bodyLarge!
                              .copyWith(fontSize: 35.sp),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: 10.w, top: 50.h),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_alt,
                            size: 35.w,
                            color: ColorManager.primary,
                          ),
                          onPressed: () {
                            Get.dialog(
                              FilterCategoryCoachDialog(
                                header: AppStrings.categoryFilter.tr,
                                buttonTitle: AppStrings.apply.tr,
                                categories: controller.categories,
                                onTapButton: (List<int> selectedId) {
                                  controller.categoriesId.value = selectedId;
                                  Get.back();
                                  controller.getCoaches();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    hint: AppStrings.search.tr,
                    hintStyle: Get.textTheme.displayMedium!,
                    filled: true,
                    style: Get.textTheme.displayMedium,
                    textEditingController: controller.searchController,
                    contentPadding:
                        EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
                    fillColor: ColorManager.white,
                    suffixIcon: InkWell(
                      onTap: () => controller.getCoaches(),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.search,
                          color: ColorManager.white,
                          size: 30.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
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
            : controller.coaches.isEmpty
                ? SizedBox(
                    height: 0.7.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.coaches.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (controller.coaches[index].isSubscription!) {
                            instance<AppPreferences>().setCoachEntity([
                              controller.coaches[index].id.toString(),
                              controller.coaches[index].lastName.toString(),
                              controller.coaches[index].avatar.toString(),
                            ]);
                            print(
                                instance<AppPreferences>().getCoachEntity()[0]);
                            print(
                                instance<AppPreferences>().getCoachEntity()[1]);
                            print(
                                instance<AppPreferences>().getCoachEntity()[2]);
                            controller.appController.onItemTapped(1);
                          } else {
                            instance<AppPreferences>().setCoachEntity([
                              controller.coaches[index].id.toString(),
                            ]);
                            Get.toNamed(Routes.shopRoute);
                          }
                        },
                        child: TrainerCard(
                          coach: controller.coaches[index],
                          // title:
                          //     "${controller.coaches[index].firstName}",
                          // image: controller.coaches[index].avatar != null
                          //     ? controller.coaches[index].avatar!
                          //     : Get.find<AppController>().defaultImage,
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1.sw / 0.8.sh,
                        crossAxisCount: 2),
                  ),
      ),
    );
  }
}
