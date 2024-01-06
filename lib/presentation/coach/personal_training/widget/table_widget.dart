import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../getx/personal_training_controller.dart';

class TableWidget extends GetView<PersonalTrainingCoachController> {
  const TableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  AppStrings.username.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displaySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.startDate.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.endDate.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.freePackage.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall,
                ),
              ),
            ],
          ),
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
              : controller.users.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : SizedBox(
                      height: 0.75.sh,
                      child: ListView.builder(
                        itemCount: controller.users.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsetsDirectional.only(top: 15.h),
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.users[index].name,
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.displaySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.users[index].startDate,
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.users[index].endDate,
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  controller.users[index].packageName,
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
