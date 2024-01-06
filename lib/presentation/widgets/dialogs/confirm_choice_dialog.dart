import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/strings_manager.dart';

class ConfirmChoiceDialog extends StatelessWidget {
  final String title;
  final String message;
  final String toDoButton;
  final Function toDo;
  final Function? toDoCancel;

  const ConfirmChoiceDialog({
    super.key,
    required this.title,
    required this.message,
    required this.toDoButton,
    required this.toDo,
    this.toDoCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      elevation: 1,
      title: Text(
        title.tr,
        style: theme.textTheme.titleLarge?.copyWith(fontSize: 23.sp),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 4.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message.tr,
                // textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (toDoCancel != null) {
                toDoCancel!();
              }
              Get.back();
            },
            child: Text(AppStrings.cancel,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18.sp))),
        TextButton(
            onPressed: () async {
              await toDo();
              Get.back();
            },
            child: Text(
              toDoButton.tr,
              style: theme.textTheme.titleMedium?.copyWith(fontSize: 18.sp),
            )),
      ],
    );
  }
}
