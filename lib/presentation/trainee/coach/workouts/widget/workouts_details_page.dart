import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class WorkoutDetailsPage extends StatelessWidget {
  const WorkoutDetailsPage(
      {required this.image,
      required this.id,
      required this.des,
      required this.title,
      required this.onTap,
      Key? key})
      : super(key: key);

  final String image;
  final String des;
  final String title;
  final int id;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: ''),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 30.verticalSpace,
            SizedBox(
              width: 1.sw,
              height: 300.h,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            15.verticalSpace,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25.w),
              child: Text(
                title,
                style: Get.textTheme.bodyLarge,
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25.w),
              child: Text(
                des,
                style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
              ),
            ),
            const Spacer(),
            Center(
              child: CustomElevatedButton(
                title: AppStrings.exploreWorkout.tr,
                width: 0.8.sw,
                onTap: () {
                  onTap();
                },
              ),
            ),
            50.verticalSpace,
          ],
        ),
        PositionedDirectional(
          end: 15,
          top: 10,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100.r)),
              child: Icon(
                Icons.share,
                color: ColorManager.primary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
