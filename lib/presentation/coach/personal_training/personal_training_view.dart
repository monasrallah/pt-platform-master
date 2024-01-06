import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../resources/strings_manager.dart';
import 'getx/personal_training_controller.dart';
import 'widget/table_widget.dart';

class PersonalTrainingCoachView
    extends GetView<PersonalTrainingCoachController> {
  const PersonalTrainingCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: buildHomeBody(),
    );
  }

  Widget buildHomeBody() {
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
            top: 80.h,
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
                  AppStrings.personalTraining.tr,
                  style: Get.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            top: 140.h,
            child: SizedBox(
              width: 1.sw,
              child: const TableWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
