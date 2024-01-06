import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../domain/entities/coach_entities/chat_entity.dart';
import '../../../../resources/strings_manager.dart';

class VideoInfoRow extends StatelessWidget {
  const VideoInfoRow({Key? key, required this.chat, required this.onTapJoin})
      : super(key: key);

  final ChatEntity chat;
  final Function onTapJoin;

  @override
  Widget build(BuildContext context) {
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
          const Spacer(),
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
