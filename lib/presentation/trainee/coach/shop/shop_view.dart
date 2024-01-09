import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/app/constants.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/buttons/app_back_bar.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/shop_controller.dart';
import 'widget/shop_card.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<AppController>().onItemTapped(1);
        return true;
      },
      child: MainBottomNavigationBar(
        appBarWidget: appBackBar(title: AppStrings.shop.tr),
        bodyWidget: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: controller.isLoading
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
              : controller.shop.premium.isEmpty &&
                      controller.shop.subscription.isEmpty &&
                      controller.shop.personalTraining.isEmpty
                  ? SizedBox(
                      height: 0.7.sh,
                      width: 1.sw,
                      child: SvgPicture.asset(IconsAssets.noData),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,

                        if (controller.shop.subscription.isNotEmpty)
                          ...buildSubscriptions(),
                        30.verticalSpace,

                        if (controller.shop.premium.isNotEmpty)
                          ...buildPremium(),
                        30.verticalSpace,

                        if (controller.shop.personalTraining.isNotEmpty)
                          ...buildPT(),
                        30.verticalSpace,

                        // Text(
                        //   "Tips",
                        //   style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
                        // ),
                        // 20.verticalSpace,
                        // SizedBox(
                        //   height: 0.16.sh,
                        //   width: 1.sw,
                        //   child: ListView.builder(
                        //     physics: const AlwaysScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemCount: 3,
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return GestureDetector(
                        //         onTap: () => Get.to(
                        //           () => const ShopDetailsPage(),
                        //         ),
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.only(end: 15.w),
                        //           child: const TipsCard(
                        //             image: ImageAssets.bronze,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        30.verticalSpace,
                      ],
                    ),
        ),
      ),
    );
  }

  List<Widget> buildPremium() {
    return [
      Text(
        AppStrings.premiumSubscriptions.tr,
        style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
      ),
      20.verticalSpace,
      Obx(
        () => controller.isLoading
            ? SizedBox(
                width: 1.sw,
                height: 0.5.sh,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : SizedBox(
                height: 0.5.sh,
                width: 1.sw,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.shop.premium.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15.w),
                      child: ShopCard(
                        image: Constants.shopImage[
                                controller.shop.premium[index].style] ??
                            "",
                        personalTraining: controller.shop.premium[index],
                      ),
                    );
                  },
                ),
              ),
      ),
    ];
  }

  List<Widget> buildSubscriptions() {
    return [
      Text(
        AppStrings.subscriptions.tr,
        style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
      ),
      20.verticalSpace,
      Obx(
        () => controller.isLoading
            ? SizedBox(
                width: 1.sw,
                height: 0.5.sh,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : controller.shop.subscription.isEmpty
                ? SizedBox(
                    height: 0.5.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : SizedBox(
                    height: 0.5.sh,
                    width: 1.sw,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.shop.subscription.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(end: 15.w),
                          child: ShopCard(
                            image: Constants.shopImage[controller
                                    .shop.subscription[index].style] ??
                                "",
                            personalTraining:
                                controller.shop.subscription[index],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    ];
  }

  List<Widget> buildPT() {
    return [
      Text(
        AppStrings.pTPackages.tr,
        style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
      ),
      20.verticalSpace,
      Obx(
        () => controller.isLoading
            ? SizedBox(
                width: 1.sw,
                height: 0.5.sh,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : controller.shop.personalTraining.isEmpty
                ? SizedBox(
                    height: 0.5.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : SizedBox(
                    height: 0.5.sh,
                    width: 1.sw,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.shop.personalTraining.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(end: 15.w),
                          child: ShopCard(
                            image: Constants.shopImage[controller
                                    .shop.personalTraining[index].style] ??
                                "",
                            personalTraining:
                                controller.shop.personalTraining[index],
                          ),
                        );
                      },
                    ),
                  ),
      ),
    ];
  }
}
