import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/resources/color_manager.dart';

class InformationDialog extends StatelessWidget {
  const InformationDialog(
      {required this.header,
      this.width,
      this.height,
      Key? key,
      this.coachName,
      this.coachCategory,
      required this.coachDesc})
      : super(key: key);
  final double? width;
  final double? height;
  final String header;
  final String? coachName;
  final List<String>? coachCategory;
  final String coachDesc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      titlePadding: EdgeInsets.all(12.w),
      title: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.white,
              size: 30.w,
            ),
          ),
          20.horizontalSpace,
          Text(
            header,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Get.context!.textTheme.bodyLarge?.copyWith(fontSize: 22.sp),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: width ?? 0.7.sw,
          // height: height ?? 0.9.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coachName.orEmpty(),
                style: Get.textTheme.bodyMedium,
              ),
              coachCategory != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: coachCategory!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Text(
                          "${coachCategory![index]} ",
                          style: Get.textTheme.bodySmall!.copyWith(height: 2),
                        );
                      },
                    )
                  : Container(),
              Text(
                coachDesc,
                style: Get.textTheme.bodySmall,
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
