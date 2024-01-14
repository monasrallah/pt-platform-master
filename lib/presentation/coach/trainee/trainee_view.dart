import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/presentation/coach/trainee/widget/choice_action.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../app/constants.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../widgets/text_fields/custom_text_field.dart';
import 'getx/trainee_controller.dart';
import 'widget/trainee_card.dart';

class TraineeCoachView extends GetView<TraineeCoachController> {
  const TraineeCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.32.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.40.sh,
              width: 1.sw,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade600.withOpacity(0.5),
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  ImageAssets.backAppBar,
                  height: 0.40.sh,
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
                  Column(
                    children: [
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          AppStrings.chooseYour.tr,
                          maxLines: 2,
                          style: Get.textTheme.bodyLarge!
                              .copyWith(fontSize: 35.sp),
                        ),
                      ),
                      SizedBox(
                        width: 0.5.sw,
                        child: Text(
                          AppStrings.trainee.tr,
                          maxLines: 2,
                          style: Get.textTheme.bodyLarge!
                              .copyWith(fontSize: 35.sp),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    hint: AppStrings.search.tr,
                    hintStyle: Get.textTheme.displayMedium!,
                    textEditingController: controller.name,
                    filled: true,
                    style: Get.textTheme.displayMedium,
                    contentPadding:
                        EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
                    fillColor: ColorManager.white,
                    suffixIcon: InkWell(
                      onTap: () => controller.getUsers(),
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
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 0.27.sh, start: 20.w, end: 20.w),
              child: Center(
                child: SizedBox(
                  height: 45.h,
                  child: ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            controller.sectionSelect.value = index;
                            controller.onChangeSection();
                          },
                          child: buildSection(
                              title: controller.sectionTitle[index],
                              color: controller.sectionSelect.value == index
                                  ? ColorManager.primary
                                  : Colors.transparent),
                        ),
                      );
                    },
                  ),
                ),
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
            : controller.users.isEmpty
                ? SizedBox(
                    height: 0.7.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.traineeId.value =
                              controller.users[index].id.toString();
                          Get.to(() => const ChoiceActionCoachView(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: TraineeCard(
                          title: controller.users[index].name,
                          start: controller.users[index].startDate,
                          end: controller.users[index].endDate,
                          image: controller.users[index].avatar ??
                              Get.find<AppController>().defaultImage,
                          colorStar: Constants.traineeColor[
                                  controller.users[index].style] ??
                              Colors.white,
                          // selected: (controller.traineeIndex.value == index).obs,
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.sw / 0.85.sh,
                        crossAxisCount: 2),
                  ),
      ),
    );
  }

  Widget buildSection({required String title, required Color color}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          title,
          style:
              Get.textTheme.bodyMedium!.copyWith(fontSize: 18.sp, height: 1.2),
        ),
      ),
    );
  }
}
