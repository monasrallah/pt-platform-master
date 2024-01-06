import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../../../resources/functions/date_format_function.dart';
import '../../getx/history_controller.dart';

class SelectDayWidget extends GetView<HistoryController> {
  const SelectDayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          20.verticalSpace,
          Obx(
            () => CustomElevatedButton(
              title: controller.date.value,
              textStyle: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
              height: 45.h,
              width: 1.sw,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(1900),
                    lastDate: DateTime.now(),
                    // lastDate: DateTime(DateTime.now().year + 20),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          shadowColor: Get.theme.colorScheme.background,
                          timePickerTheme: TimePickerTheme.of(context).copyWith(
                            //background color of time picker
                            backgroundColor: Get.theme.colorScheme.background,
                          ),
                        ),
                        child: child!,
                      );
                    });

                if (pickedDate != null) {
                  controller.date.value = dateFormat(date: pickedDate);
                  controller.selectedDate = pickedDate;
                  // checkSelectedIfValidSelectedDate();
                }
                await controller.getFoodHistory();
              },
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
