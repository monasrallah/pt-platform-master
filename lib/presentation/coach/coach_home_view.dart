import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../app/app_controller.dart';
import '../../resources/strings_manager.dart';
import '../widgets/cards/image_card.dart';
import '../widgets/dialogs/delete_account_dialog.dart';
import 'getx/coach_home_controller.dart';

class CoachHomeView extends GetView<CoachHomeController> {
  const CoachHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Get.find<AppController>().openConfirmationDialog();
      },
      child: Scaffold(
        body: buildBody(),
        backgroundColor: ColorManager.grey,
        appBar: buildSpecialStore(),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          10.verticalSpace,
          Container(
            // height: 0.5.sh,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.h),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.gridTileList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    if (controller.gridTileList[index] ==
                        AppStrings.deleteMyAccount.tr) {
                      Get.dialog(DeleteAccountDialog(
                        toDo: () async {
                          await controller.deleteAccount();
                        },
                        controller: controller.passwordController,
                      ));
                    } else if (controller.gridTileList[index] ==
                        AppStrings.logout.tr) {
                      await controller.logout();
                    }
                    return controller.gridOnTapList[index]();
                  },
                  child: ImageCard(
                    image: controller.gridImageList[index],
                    title: controller.gridTileList[index],
                    onTap: () {},
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.sw / 0.55.sh,
                  crossAxisCount: 3),
            ),
          ),
          15.verticalSpace,
        ],
      ),
    );
  }

  PreferredSizeWidget buildSpecialStore() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.29.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            SizedBox(
              width: Get.width,
              child: Obx(
                () {
                  if (controller.isLoading) {
                    return SizedBox(
                      height: 0.4.sh,
                      child: Image.network(
                        Get.find<AppController>().defaultImage,
                        fit: BoxFit.cover,
                        width: Get.width,
                      ),
                    );
                  } else {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          items: controller.imageSliders,
                          carouselController: controller.carouselController,
                          options: CarouselOptions(
                            height: 0.4.sh,
                            autoPlay: true,
                            viewportFraction: 1.0,
                            onPageChanged: (index, _) {
                              controller.indexSpecialStore.value = index;
                            },
                          ),
                        ),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                controller.banners.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => controller.carouselController
                                    .animateToPage(entry.key),
                                child: Obx(
                                  () => Container(
                                    width: 11.w,
                                    height: 11.h,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Get.theme.brightness ==
                                                    Brightness.dark
                                                ? Colors.grey
                                                : Colors.white)
                                            .withOpacity(controller
                                                        .indexSpecialStore
                                                        .value ==
                                                    entry.key
                                                ? 0.9
                                                : 0.4)),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
