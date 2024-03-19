import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:pt_platform/resources/color_manager.dart';

import '../../../resources/strings_manager.dart';
import '../buttons/custom_elevated_button.dart';
import '../toasts_messages.dart';

class UpdateBodyMeasurementsDialog extends StatelessWidget {
  const UpdateBodyMeasurementsDialog(
      {required this.header,
      this.width,
      this.height,
      required this.buttonTitle,
      required this.prefixTitle,
      required this.fieldsController,
      required this.onTap,
      Key? key})
      : super(key: key);
  final double? width;
  final double? height;
  final String header;
  final String buttonTitle;
  final Function onTap;
  final List<String> prefixTitle;
  final List<TextEditingController> fieldsController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r))),
      titlePadding: EdgeInsets.all(12.w),
      title: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: ColorManager.white,
              size: 30.w,
            ),
          ),
          20.horizontalSpace,
          Text(
            header,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Get.context!.textTheme.bodyLarge?.copyWith(fontSize: 22.sp),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: width ?? 0.7.sw,
          // height: height ?? 0.9.sh,
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: prefixTitle.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: CustomTextField(
                      hint: "", isPhone: false,
                      textInputType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      color: ColorManager.white,
                      cursorColor: ColorManager.white,
                      textEditingController: fieldsController[index],
                      // readOnly: prefixTitle[index] == "DATE",
                      prefix: Padding(
                        padding: EdgeInsetsDirectional.only(start: 12.w),
                        child: Text(
                          "${prefixTitle[index]} : ",
                          style: Get.textTheme.bodySmall!.copyWith(height: 3),
                        ),
                      ),
                      // onTap: prefixTitle[index] != "DATE"
                      //     ? () {}
                      //     : () async {
                      //         DateTime? pickedDate = await showDatePicker(
                      //             context: context,
                      //             initialDate: DateTime.now(),
                      //             firstDate: DateTime.utc(1900),
                      //             lastDate: DateTime.now(),
                      //             // lastDate: DateTime(DateTime.now().year + 20),
                      //             builder: (context, child) {
                      //               return Theme(
                      //                 data: Theme.of(context).copyWith(
                      //                   shadowColor:
                      //                       Get.theme.colorScheme.background,
                      //                   timePickerTheme:
                      //                       TimePickerTheme.of(context)
                      //                           .copyWith(
                      //                     //background color of time picker
                      //                     backgroundColor:
                      //                         Get.theme.colorScheme.background,
                      //                   ),
                      //                 ),
                      //                 child: child!,
                      //               );
                      //             });
                      //
                      //         if (pickedDate != null) {
                      //           fieldsController[index].text =
                      //               dateFormat(date: pickedDate);
                      //           // controller.selectedBirthdateDate = pickedDate;
                      //           // controller.checkSelectedIfValidSelectedDate();
                      //         }
                      //       },
                    ),
                  );
                },
              ),
              20.verticalSpace,
              Center(
                child: CustomElevatedButton(
                  title: buttonTitle,
                  textStyle: Get.textTheme.displayMedium,
                  width: 150,
                  backgroundColor: ColorManager.white,
                  onTap: () {
                    // bool valid = true;
                    // for (int i = 0; i < fieldsController.length - 1; i++) {
                    //   if (fieldsController[i].text.isEmpty) {
                    //     valid = false;
                    //     break;
                    //   }
                    // }
                    // if (valid) {
                      onTap();
                    // } else {
                      // showFlutterToast(
                      //   message: AppStrings.pleaseEnterTheValues.tr,
                      // );
                    // }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
