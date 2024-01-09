import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/custom_expantion_tile_widget.dart';
import '../../../widgets/custom_percent_indeicator.dart';
import '../../../widgets/dialogs/update_body_measurements_dialog.dart';
import '../../../widgets/dialogs/update_progress_dialog.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/progress_controller.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: Obx(() => controller.isLoading
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
          : buildBody()),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.27.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            SizedBox(
              // height: 0.30.sh,
              width: 1.sw,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.grey.shade800.withOpacity(0.5),
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
                children: [
                  Row(
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
                        AppStrings.progress.tr,
                        style: Get.textTheme.displayLarge!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ],
                  ),
                  30.verticalSpace,
                  Obx(
                    () => controller.isLoading
                        ? SizedBox(
                            width: 1.sw,
                            height: 0.1.sh,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox.shrink(),
                              ],
                            ),
                          )
                        : controller.progressAmount.isNotEmpty
                            ? buildRowPercent()
                            : Container(),
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
    return SingleChildScrollView(
      child: controller.measurementsAmountList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 20.verticalSpace,
                buildExpansion(),
                20.verticalSpace,
                buildBodyMeasurements(),
              ],
            )
          : SizedBox(
              height: 0.5.sh,
              width: 1.sw,
              child: SvgPicture.asset(IconsAssets.noData),
            ),
    );
  }

  Widget buildRowPercent() {
    return Row(
      children: [
        Obx(
          () => CustomCircularPercentIndicator(
              title: AppStrings.fat.tr,
              iconType: controller.progressAmount[2].percentage.type,
              text:
                  "${(controller.progressAmount[2].percentage.value).toStringAsFixed(1)} %",
              progressColor: Colors.red,
              percent: controller.progressAmount[2].percentage.value / 100 > 1
                  ? 1
                  : controller.progressAmount[2].percentage.value / 100),
        ),
        30.horizontalSpace,
        Obx(
          () => CustomCircularPercentIndicator(
              title: AppStrings.muscle.tr,
              text:
                  "${(controller.progressAmount[1].percentage.value).toStringAsFixed(1)} %",
              iconType: controller.progressAmount[1].percentage.type,
              progressColor: Colors.green,
              percent: controller.progressAmount[1].percentage.value / 100 > 1
                  ? 1
                  : controller.progressAmount[1].percentage.value / 100),
        ),
        30.horizontalSpace,
        Obx(
          () => CustomCircularPercentIndicator(
              title: AppStrings.weight.tr,
              text:
                  "${(controller.progressAmount[0].percentage.value).toStringAsFixed(1)} %",
              iconType: controller.progressAmount[0].percentage.type,
              progressColor: Colors.yellow,
              percent: controller.progressAmount[0].percentage.value / 100 > 1
                  ? 1
                  : controller.progressAmount[0].percentage.value / 100),
        ),
        30.horizontalSpace,
        Obx(
          () => CustomCircularPercentIndicator(
              title: AppStrings.water.tr,
              text:
                  "${(controller.progressAmount[3].percentage.value).toStringAsFixed(1)} %",
              iconType: controller.progressAmount[3].percentage.type,
              progressColor: Colors.blue,
              percent: controller.progressAmount[3].percentage.value / 100 > 1
                  ? 1
                  : controller.progressAmount[3].percentage.value / 100),
        ),
      ],
    );
  }

  Widget buildExpansion() {
    return Column(
      children: [
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("0"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.weight.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[0].weight} kg",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("1"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.muscle.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[1].muscle} kg",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("2"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.fat.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[2].fat.toDouble()} kg",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("3"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.water.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[3].water.toDouble()} litter",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("4"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.activeCalories.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[4].activeCalories.toDouble()} calories",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        CustomExpansionTile(
          expandedItem: controller.expanded,
          key: const Key("5"),
          title: Padding(
            padding: EdgeInsetsDirectional.only(start: 5.w),
            child: SizedBox(
                width: 0.7.sw,
                child: Text(
                  AppStrings.steps.tr,
                  style: Get.textTheme.displayMedium?.copyWith(fontSize: 20.sp),
                )),
          ),
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorManager.primary,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
              child: SizedBox(
                width: 1.sw,
                child: Text(
                  "${controller.progressAmount[5].steps.toDouble()} steps",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyMedium?.copyWith(fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
        12.verticalSpace,
        CustomElevatedButton(
          title: AppStrings.update.tr,
          textStyle: Get.textTheme.bodySmall,
          width: 0.5.sw,
          height: 40.h,
          onTap: () {
            showAdaptiveDialog(
                barrierDismissible: false,
                context: Get.context!,
                builder: (context) {
                  return UpdateProgressDialog(
                    header: AppStrings.addNewValue.tr,
                    buttonTitle: AppStrings.update.tr,
                    listOfController: controller.listOfController,
                    onTap: () async {
                      await controller.updateProgress();
                    },
                  );
                });
          },
        ),
      ],
    );
  }

  Widget buildBodyMeasurements() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w),
            child: Text(AppStrings.bodyMeasurements.tr),
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: buildMeasurementsColumn(title: AppStrings.before),
              ),
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  ImageAssets.body,
                  height: 500.h,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                flex: 3,
                child: Obx(() => controller.isLoading
                    ? Container()
                    : buildMeasurementsColumn(title: AppStrings.after)),
              ),
            ],
          ),
          12.verticalSpace,
          Center(
            child: CustomElevatedButton(
              title: AppStrings.addBodyMeasurements.tr,
              textStyle: Get.textTheme.bodySmall,
              width: 0.7.sw,
              height: 40.h,
              onTap: () {
                showAdaptiveDialog(
                  barrierDismissible: false,
                  context: Get.context!,
                  builder: (context) {
                    return UpdateBodyMeasurementsDialog(
                      header: AppStrings.addNewValue.tr,
                      buttonTitle: AppStrings.update.tr,
                      onTap: () async {
                        await controller.updateMeasurements();
                      },
                      prefixTitle: controller.measurementsDialogList,
                      fieldsController: controller.listOfMeasurementsController,
                    );
                  },
                );
              },
            ),
          ),
          12.verticalSpace,
        ],
      ),
    );
  }

  Widget buildMeasurementsColumn({required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 1.h),
            color: ColorManager.primary,
            child: Text(
              title.tr,
              style: Get.textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
            ),
          ),
        ),
        12.verticalSpace,
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.measurementsList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => buildBorderContainer(
                  first: controller.measurementsList[index],
                  second: title == "before"
                      ? controller.measurementsBeforeAmount[index]
                      : controller.measurementsAfterAmount[index]),
            );
          },
        ),
      ],
    );
  }

  Widget buildBorderContainer({required String first, required String second}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorManager.white14, width: 1),
        ),
        child: Row(
          children: [
            Text(
              "${first.tr} : ",
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 11.sp),
            ),
            SizedBox(
              width: first == "DATE" ? 70.w : 45.w,
              child: Text(
                second,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.bodySmall!.copyWith(fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
