import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage(
      {required this.image, required this.title, required this.des, Key? key})
      : super(key: key);
  final String image;
  final String title;
  final String des;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.news.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          30.verticalSpace,
          Image.network(
            image,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.verticalSpace,
                Text(
                  title,
                  style: Get.textTheme.bodyLarge,
                ),
                20.verticalSpace,
                Text(
                  title,
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
