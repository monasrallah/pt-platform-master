import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../domain/entities/home_entities/recipe_entity.dart';
import '../../../../../widgets/buttons/app_back_bar.dart';
import '../../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class SupplementsDetailsPage extends StatelessWidget {
  const SupplementsDetailsPage(
      {required this.supplements, Key? key, required this.link})
      : super(key: key);
  final RecipeEntity supplements;
  final String link;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(
          title: AppStrings.supplements.tr,
          withAction: true,
          onTapAction: () async {
            await launchUrl(Uri.parse(link));
          }),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.verticalSpace,
              Stack(
                children: [
                  Container(
                    width: 1.sw,
                    height: 330.h,
                    color: ColorManager.white,
                  ),
                  Container(
                    height: 300.h,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Image.network(
                        supplements.image.orEmpty(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Text(
                supplements.title,
                style: Get.textTheme.bodyLarge,
              ),
              20.verticalSpace,
              HtmlWidget(
                supplements.description, renderMode: RenderMode.column,
                // set the default styling for text
                onTapUrl: (value) async {
                  return await launchUrl(Uri.parse(value));
                },
                textStyle: Get.textTheme.bodySmall!.copyWith(fontSize: 16.sp),
              ),
              // Text(
              //   supplements.description,
              //   style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
