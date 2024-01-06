import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/assets_manager.dart';
import '../../widgets/cards/home_image_card.dart';
import '../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Get.find<AppController>().openConfirmationDialog();
      },
      child: MainBottomNavigationBar(
        bodyWidget: buildBody(),
        backgroundColor: ColorManager.grey,
        appBarWidget: buildSpecialStore(),
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        SizedBox(
          height: 0.7.sh,
          width: 1.sw,
          child: Image.asset(
            ImageAssets.darkBackground,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 0.7.sh,
            //   width: 1.sw,
            //   child: Image.asset(
            //     ImageAssets.darkBackground,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // PositionedDirectional(
            //   top: 150,
            //   start: 0.09.sw,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 0.5.h,
            //         width: 0.83.sw,
            //         color: ColorManager.primary,
            //       ),
            //       3.verticalSpace,
            //       Container(
            //         height:  0.5.h,
            //         width: 0.83.sw,
            //         color: ColorManager.primary,
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: 0.17.sh,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.h),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.gridTileList1.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => controller.gridOnTapList1[index](),
                    child: HomeImageCard(
                      image: controller.gridImageList1[index],
                      title: controller.gridTileList1[index],
                      onTap: () {},
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.sw / 0.5.sh,
                    crossAxisCount: 3),
              ),
            ),
            // PositionedDirectional(
            // top: 150,
            // start: 0.09.sw,child:
            Column(
              children: [
                Container(
                  height: 0.5.h,
                  width: 0.83.sw,
                  color: ColorManager.primary,
                ),
                3.verticalSpace,
                Container(
                  height: 0.5.h,
                  width: 0.83.sw,
                  color: ColorManager.primary,
                ),
              ],
            ),
            // ),
            Container(
              height: 0.37.sh,
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.h),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.gridTileList2.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => controller.gridOnTapList2[index](),
                    child: HomeImageCard(
                      image: controller.gridImageList2[index],
                      title: controller.gridTileList2[index],
                      onTap: () {},
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.sw / 0.5.sh,
                    crossAxisCount: 3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PreferredSizeWidget buildSpecialStore() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.29.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            InkWell(
              onTap: () async {
                await launchUrl(Uri.parse(controller.banners[0].url));
              },
              child: SizedBox(
                width: Get.width,
                height: 0.4.sh,
                child: Obx(
                  () => Image.network(
                    controller.isLoading || controller.banners.isEmpty
                        ? Get.find<AppController>().defaultImage
                        : controller.banners[0].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
