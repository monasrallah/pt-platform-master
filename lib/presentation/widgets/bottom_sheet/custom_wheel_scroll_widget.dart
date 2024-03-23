import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/dependency_injection.dart';
import 'package:pt_platform/app/storage/app_prefs.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../trainee/coach/getx/coach_controller.dart';

typedef OnChangedCallback = void Function(dynamic value);

class CustomWheelScrollWidget extends GetView<CoachController> {
  const CustomWheelScrollWidget(
      {Key? key,
      required this.data,
      required this.dataList,
      this.index,
      required this.onChanged})
      : super(key: key);
  final RxString data;
  final RxInt? index;
  final OnChangedCallback onChanged;

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
              // onValueChanged: onChanged,
              onValueChanged: (value) async {
                onChanged(value);
                print("test onValueChanged $value");
                for (var i = 0; i < dataList.length; i++) {
                  if (controller.coaches[i].lastName == value) {
                    print("heeeeeh ${controller.coachId.value}");
                    controller.coachId.value =
                        controller.coaches[i].id.toString();
                    controller.coachName.value =
                        controller.coaches[i].firstName.toString();
                    controller.coachAvatar.value =
                        controller.coaches[i].avatar.toString();

                    controller.getBanner();
                  } else {
                    print("heeeee h");
                  }
                }

                print("test onValueChanged ${controller.coachId}");
                print("test onValueChanged ${controller.coachIndex.value}");
                print("Test ${controller.coaches.map((e) => e.id).toList()}");
                print(
                    "testttsss  1 ${instance<AppPreferences>().getCoachEntity()[0]}");

                await instance<AppPreferences>().setCoachEntity([
                  controller.coachId.toString(),
                  controller.coachName.value.toString(),
                  controller.coachAvatar.toString(),
                ]);
                print(
                    "test onValueChanged ${instance<AppPreferences>().getCoachEntity()[0]}");

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
