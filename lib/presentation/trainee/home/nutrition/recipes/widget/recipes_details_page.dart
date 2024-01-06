import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/home/nutrition/recipes/getx/recipes_controller.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';
import 'package:redacted/redacted.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../domain/entities/home_entities/recipe_entity.dart';
import '../../../../../widgets/buttons/app_back_bar.dart';
import '../../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class RecipesDetailsPage extends GetView<RecipesController> {
  const RecipesDetailsPage({required this.link, required this.recipe, Key? key})
      : super(key: key);
  final RecipeEntity recipe;
  final String link;

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(
          title: AppStrings.recipesAndDietPlans.tr,
          withAction: true,
          onTapAction: () async {
            await launchUrl(Uri.parse(link));
          }),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          10.verticalSpace,
          SizedBox(
            width: 1.sw,
            height: 200.h,
            child: Image.network(
              recipe.image!,
              fit: BoxFit.none,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                15.verticalSpace,
                Text(
                  recipe.title,
                  style: Get.textTheme.bodyMedium,
                ),
                10.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name!,
                      style:
                          Get.textTheme.displaySmall!.copyWith(fontSize: 16.sp),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.av_timer_rounded,
                          color: ColorManager.primary,
                          size: 22.w,
                        ),
                        10.horizontalSpace,
                        Text(
                          "${recipe.time} ${AppStrings.minute.tr}",
                          style: Get.textTheme.displaySmall!
                              .copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    buildIngredients(),
                    buildHowToMakeIt(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 60.h,
        width: 1.sw,
        color: Colors.grey.shade700,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          title,
          style: Get.textTheme.bodySmall!.copyWith(fontSize: 22.sp),
        ),
      ),
    );
  }

  Widget buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContainer(title: "Ingredients"),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipe.ingredients!.length,
            itemBuilder: (context, index) {
              return Text(
                "- ${recipe.ingredients![index]}",
                style: Get.textTheme.bodySmall!.copyWith(fontSize: 16.sp),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildHowToMakeIt() {
    return Column(
      children: [
        buildContainer(title: "How to make it"),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => controller.isLoading
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text("").redacted(
                              context: context,
                              redact: true,
                              configuration: RedactedConfiguration(
                                animationDuration:
                                    const Duration(milliseconds: 800), //default
                              ),
                            ),
                          );
                        },
                      )
                    : HtmlWidget(recipe.description,
                        renderMode: RenderMode.column, onTapUrl: (value) async {
                        return await launchUrl(Uri.parse(value));
                      },
                        // set the default styling for text
                        textStyle:
                            Get.textTheme.bodySmall!.copyWith(fontSize: 16.sp)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
