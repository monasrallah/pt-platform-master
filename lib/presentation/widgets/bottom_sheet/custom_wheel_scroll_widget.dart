import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class CustomWheelScrollWidget extends StatelessWidget {
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
              onValueChanged: (value, value2) {
                data.value = value;
                // this.index != null ? this.index!.value = index : null;
              },
              datas: dataList,
            ),
          ),
        ],
      ),
    );
  }
}
