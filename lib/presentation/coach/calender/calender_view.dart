import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/coach/calender/getx/calender_controller.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../resources/color_manager.dart';

import 'widget/table_widget.dart';

class CalenderCoachView extends GetView<CalenderCoachController> {
  const CalenderCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBackBar(title: 'Calender'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SizedBox(
      height: 1.sh,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade600.withOpacity(0.2),
                  ColorManager.black
                ], // define your own color range here
              ),
            ),
            height: 1.sh,
            width: 1.sw,
            child: Align(
              alignment: Alignment.topCenter,
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
          ),
          PositionedDirectional(
            top: 50.h,
            start: 20.w,
            child: Row(
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
                  AppStrings.calendar.tr,
                  style: Get.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 140.h,
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
                  : controller.calenders.isEmpty
                      ? SizedBox(
                          height: 0.7.sh,
                          width: 1.sw,
                          child: SvgPicture.asset(IconsAssets.noData),
                        )
                      : SizedBox(
                          width: 1.sw,
                          child: TableWidget(calenders: controller.calenders),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
