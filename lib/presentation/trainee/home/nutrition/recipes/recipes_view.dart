import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/recipes/getx/recipes_controller.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/assets_manager.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'widget/recipes_card.dart';
import 'widget/recipes_details_page.dart';

class RecipesView extends GetView<RecipesController> {
  const RecipesView({Key? key}) : super(key: key);

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
                    AppStrings.recipesAndDietPlans.tr,
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
                textEditingController: controller.nameController,
                style: Get.textTheme.displayMedium,
                contentPadding:
                    EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
                fillColor: ColorManager.white,
                suffixIcon: InkWell(
                  onTap: () async => await controller.getRecipes(),
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
            : controller.recipes.isEmpty
                ? SizedBox(
                    height: 0.7.sh,
                    width: 1.sw,
                    child: SvgPicture.asset(IconsAssets.noData),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.recipes.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          String link = Get.find<AppController>().getLinkInfo(
                              index: index,
                              htmlText: controller.recipes[index].description);
                          Get.to(
                            () => RecipesDetailsPage(
                              recipe: controller.recipes[index],
                              link: link,
                            ),
                          );
                        },
                        child: RecipesCard(
                          image: controller.recipes[index].image!,
                          title: controller.recipes[index].title,
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.sw / 0.9.sh,
                        crossAxisCount: 2),
                  ),
      ),
    );
  }
}
