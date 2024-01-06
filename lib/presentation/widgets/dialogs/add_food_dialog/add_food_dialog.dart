import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../resources/strings_manager.dart';
import '../../buttons/custom_elevated_button.dart';
import 'add_food_controller.dart';

class AddFoodDialog extends GetView<AddFoodController> {
  AddFoodDialog(
      {this.width,
      this.height,
      required this.titles,
      required this.onTap,
      required this.selectedItem,
      Key? key})
      : super(key: key);

  final double? width;
  final double? height;
  final Function(AddFoodEntity) onTap;
  final List<AddFoodEntity> titles;
  AddFoodEntity selectedItem;

  @override
  Widget build(BuildContext context) {
    // controller.searchList.clear();

    controller.searchList.addAll(titles);
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      titlePadding: EdgeInsets.fromLTRB(0, 12.h, 12.w, 6.h),
      title: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => {Get.back(), controller.search.clear()},
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.white,
                size: 30.w,
              ),
            ),
          ),
          // 20.horizontalSpace,
          Expanded(
            flex: 7,
            child: CustomTextField(
              hint: AppStrings.search.tr,
              hintStyle: Get.textTheme.headlineSmall!,
              textEditingController: controller.search,
              filled: true,
              style: Get.textTheme.displayMedium,
              contentPadding:
                  EdgeInsetsDirectional.only(top: 12.h, start: 20.w),
              fillColor: ColorManager.white,
              onSubmit: (value) {
                controller.skip.value = 0;
                controller.getFood(controller.skip.value);
              },
              suffixIcon: InkWell(
                onTap: () {
                  controller.skip.value = 0;
                  controller.getFood(controller.skip.value);
                },
                child: Icon(
                  Icons.search,
                  color: ColorManager.primary,
                  size: 30.w,
                ),
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: width ?? 1.sw,
          // height: 0.5.sh,
          //skip.value += 15
          child: Obx(
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
                : Column(
                    children: [
                      SizedBox(
                        height: 0.4.sh,
                        child: SmartRefresher(
                          controller: controller.refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          // onRefresh: () async => await controller.onRefresh(),
                          onLoading: () async => await controller.onLoading(),
                          footer: CustomFooter(
                            builder: (BuildContext context, LoadStatus? mode) {
                              Widget body;
                              if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              } else if (mode == LoadStatus.failed) {
                                body = const Text("Load Failed!Click retry!");
                              } else if (mode == LoadStatus.canLoading) {
                                body = const Text("release to load more");
                              } else {
                                body = const Text("No More Data");
                              }
                              return SizedBox(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.searchList.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      controller.selected.value = index;
                                      selectedItem = controller.searchList[
                                          controller.selected.value];
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20.h),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color:
                                              controller.selected.value == index
                                                  ? Colors.grey.shade400
                                                  : null,
                                          border: Border.all(
                                              color: ColorManager.white)),
                                      child: Text(
                                        controller.searchList[index].title,
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: CustomElevatedButton(
                          title: AppStrings.select.tr,
                          textStyle: Get.textTheme.displayMedium,
                          width: 150,
                          backgroundColor: ColorManager.white,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            onTap(controller
                                .searchList[controller.selected.value]);
                            controller.search.clear();
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
