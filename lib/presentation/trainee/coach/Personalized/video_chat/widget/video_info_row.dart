import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../../app/functions.dart';
import '../../../../../../domain/entities/coach_entities/chat_entity.dart';

class VideoInfoRow extends StatelessWidget {
  const VideoInfoRow(
      {required this.chat,
      Key? key,
      required this.onTapJoin,
      required this.onTapCancel})
      : super(key: key);

  final ChatEntity chat;
  final Function onTapJoin;
  final Function onTapCancel;

  @override
  Widget build(BuildContext context) {
    // TimeOfDay t = TimeOfDay(
    //     hour: int.parse(chat.time.split(":")[0]),
    //     minute: int.parse(chat.time.split(":")[1]));
    // TimeOfDay t2 = t.plusMinutes(-15); // t2 is 10:15
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.username,
                  style: Get.textTheme.displayMedium!.copyWith(fontSize: 19.sp),
                ),
                Text(
                  "${chat.date}/${chat.time}",
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 15.sp),
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          if (isGreaterThanQuarterHour(chat.time, chat.date))
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                title: AppStrings.cancel.tr,
                height: 40,
                borderRadius: BorderRadius.circular(40.r),
                textStyle: Get.textTheme.bodySmall,
                onTap: () {
                  onTapCancel();
                },
              ),
            ),
          // 10.horizontalSpace,
          if (!isGreaterThanQuarterHour(chat.time, chat.date))
            Expanded(
              flex: 2,
              child: CustomElevatedButton(
                title: AppStrings.join.tr,
                height: 40,
                borderRadius: BorderRadius.circular(40.r),
                textStyle: Get.textTheme.bodySmall,
                onTap: () {
                  onTapJoin();
                },
              ),
            ),
        ],
      ),
    );
  }
}
