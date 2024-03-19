import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pt_platform/resources/color_manager.dart';

class CustomCircularPercentIndicator extends StatelessWidget {
  const CustomCircularPercentIndicator(
      {Key? key,
      this.radius,
      this.lineWidth,
      this.iconType,
      required this.percent,
      this.text = "",
      this.title,
      this.centers,
      this.backgroundColor,
      required this.progressColor})
      : super(key: key);
  final double? radius;
  final double? lineWidth;
  final double percent;
  final String text;
  final String? iconType;
  final List<Widget>? centers;
  final String? title;
  final Color? backgroundColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 40.w,
        child: CircularPercentIndicator(
          radius: radius ?? 50.r,
          animation: true,
          animationDuration: 1000,
          lineWidth: lineWidth ?? 6.w,
          percent: percent,
          footer: title != null
              ? Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text(
                          title!,
                          style: Get.textTheme.bodySmall!
                              .copyWith(fontSize: 15.sp),
                        ),
                        iconType != null
                            ? Icon(
                                iconType == "increase"
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down_sharp,
                                color: iconType == "increase"
                                    ? Colors.blueAccent
                                    : ColorManager.logout,
                                size: 22.w,
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                )
              : null,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: centers ??
                [
                  Text(
                    text,
                    style: Get.textTheme.bodySmall,
                  ),
                ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: backgroundColor ?? ColorManager.white,
          progressColor: progressColor,
        ),
      ),
    );
  }
}
