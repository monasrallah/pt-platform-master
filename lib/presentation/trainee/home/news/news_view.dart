import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/news_controller.dart';
import 'widget/news_card.dart';
import 'widget/news_details_page.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.news.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return Obx(
      () => controller.isLoading
          ? SizedBox(
              width: 1.sw,
              height: 0.7.sh,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : controller.news.isEmpty
              ? SizedBox(
                  height: 0.7.sh,
                  width: 1.sw,
                  child: SvgPicture.asset(IconsAssets.noData),
                )
              : ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.to(() => NewsDetailsPage(
                            image: controller.news[index].image,
                            title: controller.news[index].title,
                            des: controller.news[index].description,
                          )),
                      child: NewsCard(
                        title: controller.news[index].title,
                        iconImage: controller.news[index].image,
                      ),
                    );
                  },
                ),
    );
  }
}
