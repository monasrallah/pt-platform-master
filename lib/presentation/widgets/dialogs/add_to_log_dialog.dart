import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../resources/strings_manager.dart';
import '../buttons/custom_elevated_button.dart';
import '../drop_downs/drop_down_search.dart';
import '../toasts_messages.dart';

class AddToLogDialog extends StatelessWidget {
  AddToLogDialog(
      {required this.weightUnit,
      required this.sets,
      Key? key,
      required this.onTap,
      required this.textController})
      : super(key: key);

  final List<String> weightUnit;
  final int sets;
  final List<TextEditingController> textController;
  final Function onTap;

  RxBool isSetSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: 0.7.sw,
          // height: height ?? 0.9.sh,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Sets",
                      style: Get.textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: dropDownSetsList(),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      AppStrings.weightUnit.tr,
                      style: Get.textTheme.bodySmall,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: dropDownWeightUnitList(),
                  ),
                ],
              ),
              20.verticalSpace,
              CustomTextField(
                hint: AppStrings.weight.tr,
                textEditingController: textController[2],
                hintStyle:
                    Get.textTheme.headlineSmall!.copyWith(fontSize: 17.sp),
                style: Get.textTheme.titleSmall,
                textInputType: TextInputType.number,
                cursorColor: ColorManager.primary,
                filled: true,
                fillColor: ColorManager.white,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              10.verticalSpace,
              CustomTextField(
                hint: AppStrings.repetition.tr,
                textEditingController: textController[3],
                hintStyle:
                    Get.textTheme.headlineSmall!.copyWith(fontSize: 17.sp),
                textInputType: TextInputType.number,
                style: Get.textTheme.titleSmall,
                // color: ColorManager.white,
                cursorColor: ColorManager.primary,
                filled: true,
                fillColor: ColorManager.white,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              10.verticalSpace,
              CustomTextField(
                hint: AppStrings.note.tr,
                textEditingController: textController[4],
                hintStyle:
                    Get.textTheme.headlineSmall!.copyWith(fontSize: 17.sp),
                // textInputType: TextInputType.number,
                style: Get.textTheme.titleSmall,
                cursorColor: ColorManager.primary,
                filled: true,
                fillColor: ColorManager.white,
              ),
              20.verticalSpace,
              Center(
                child: CustomElevatedButton(
                  title: AppStrings.save.tr,
                  textStyle: Get.textTheme.displayMedium,
                  width: 150,
                  backgroundColor: ColorManager.white,
                  onTap: () {
                    bool valid = true;
                    for (int i = 0; i < textController.length - 1; i++) {
                      if (textController[i].text.isEmpty) {
                        valid = false;
                        break;
                      }
                    }
                    if (valid) {
                      if (int.parse(textController[0].text) == 1) {
                        onTap();
                        Get.back();
                        textController[2].clear();
                        textController[3].clear();
                        textController[4].clear();
                      } else {
                        textController[0].text =
                            (int.parse(textController[0].text) - 1).toString();

                        onTap();
                        showFlutterToast(
                            message: AppStrings.pleaseEnterTheNextSetValue.tr);
                        textController[2].clear();
                        textController[3].clear();
                        textController[4].clear();
                      }
                      isSetSelected.value = true;
                    } else {
                      showFlutterToast(
                          message: AppStrings.pleaseEnterTheValues.tr);
                    }
                    // return
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dropDownWeightUnitList() {
    return CustomDropDownSearch(
      items: weightUnit,
      selectedItem: textController[1].text,
      maxHeight: 200.h,
      enabled: !isSetSelected.value,
      onChanged: (String? data) {
        textController[1].text = data ?? "";
      },
      textStyle: Get.textTheme.titleSmall!.copyWith(fontSize: 20.sp),
    );
  }

  dropDownSetsList() {
    return Obx(
      () => CustomDropDownSearch(
        items: List.generate(sets, (index) => (index + 1).toString()),
        selectedItem: textController[0].text,
        maxHeight: 200.h,
        enabled: !isSetSelected.value,
        onChanged: (String? data) {
          textController[0].text = data ?? "";
          // isSetSelected.value = true;
        },
        textStyle: Get.textTheme.titleSmall!.copyWith(fontSize: 20.sp),
      ),
    );
  }
}
