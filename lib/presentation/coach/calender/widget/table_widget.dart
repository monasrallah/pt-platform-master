import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/functions/date_format_function.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../domain/entities/coach_app_entity/calender_entity.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({required this.calenders, Key? key}) : super(key: key);

  final List<CalenderCoachEntity> calenders;

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
                  AppStrings.name.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displaySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.date.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.time.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Text(
                  AppStrings.status.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.displaySmall,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          SizedBox(
            height: 0.75.sh,
            child: ListView.builder(
              itemCount: calenders.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(top: 15.h),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "${calenders[index].userName}",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.displaySmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          dateFormat(date: calenders[index].date),
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          calenders[index].time,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          calenders[index].status.name.toLowerCase(),
                          textAlign: TextAlign.center,
                          style: Get.textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
