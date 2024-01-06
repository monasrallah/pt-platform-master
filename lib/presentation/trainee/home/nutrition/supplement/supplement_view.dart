import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/supplement/getx/supplement_controller.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../resources/strings_manager.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/supplement_card.dart';
import 'widget/supplement_details_page.dart';

class SupplementView extends GetView<SupplementController> {
  const SupplementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: buildAppBar(),
      bodyWidget: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.2.sh),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorManager.primary,
                      size: 30.w,
                    ),
                  ),
                  40.horizontalSpace,
                  Text(
                    AppStrings.supplements.tr,
                    style:
                        Get.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
                  ),
                ],
              ),
              30.verticalSpace,
              CustomTextField(
                hint: AppStrings.search.tr,
                hintStyle: Get.textTheme.displayMedium!,
                filled: true,
                style: Get.textTheme.displayMedium,
                textEditingController: controller.nameController,
                contentPadding:
                    EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
                fillColor: ColorManager.white,
                suffixIcon: InkWell(
                  onTap: () async => await controller.getSupplements(),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.search,
                      color: ColorManager.white,
                      size: 30.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Obx(
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
            : controller.supplements.isEmpty
                ? SizedBox(
                    height: 0.7.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.supplements.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          String link = Get.find<AppController>().getLinkInfo(
                              index: index,
                              htmlText:
                                  controller.supplements[index].description);
                          Get.to(
                            () => SupplementsDetailsPage(
                              supplements: controller.supplements[index],
                              link: link,
                            ),
                          );
                        },
                        child: SupplementCard(
                          title: controller.supplements[index].title,
                          image: controller.supplements[index].image!,
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1.sw / 0.9.sh,
                        crossAxisCount: 2),
                  ),
      ),
    );
  }
}
