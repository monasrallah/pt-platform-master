import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../app/dependency_injection.dart';
import '../../../app/storage/app_prefs.dart';
import '../../trainee/coach/getx/coach_controller.dart';

class CustomWheelScrollWidget extends GetView<CoachController> {
  const CustomWheelScrollWidget(
      {Key? key, required this.data, required this.dataList, this.index})
      : super(key: key);
  final RxString data;
  final RxInt? index;

  final List<String> dataList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.36.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(12.w),
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: () => Get.back(),
              child: Text(
                "Done",
                style: Get.textTheme.labelLarge!
                    .copyWith(fontSize: 20.sp, color: ColorManager.primary),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            height: 0.3.sh,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: WheelChooser(
              selectTextStyle:
                  Get.textTheme.labelLarge!.copyWith(fontSize: 17.sp),
              unSelectTextStyle:
                  Get.textTheme.headlineMedium!.copyWith(fontSize: 15.sp),
              onValueChanged: (value) async{
                print("test onValueChanged $value");
                for (var i = 0; i < dataList.length; i++) {
                  if (controller.coaches[i].lastName == value) {
                    print("heeeeeh");
                    controller.coachId.value = controller
                        .coaches[i].id
                        .toString();
                    controller.coachAvatar.value = controller
                        .coaches[i].avatar.toString();

                controller.getBanner();
                  } else {
                    print("heeeee h");
                  }
                }

                print("test onValueChanged ${controller.coachId}");
                print("Test ${controller.coaches.map((e) => e.id).toList()}");
                instance<AppPreferences>().setCoachEntity([
                  controller.coaches[controller.coachIndex.value].id.toString(),
                  controller.coaches[controller.coachIndex.value].lastName.toString(),
                  controller.coaches[controller.coachIndex.value].logo.toString(),
                  controller.coaches[controller.coachIndex.value].avatar.toString(),

                ]);
                data.value = value;
              },
              datas: dataList,
            ),
          ),
        ],
      ),
    );
  }
}
