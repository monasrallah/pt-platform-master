import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../resources/functions/pick_image_function.dart';
import '../../../resources/strings_manager.dart';

class PickImageSourceDialog extends StatelessWidget {
  final Function? onTap;
  final bool isMultiSelect;

  const PickImageSourceDialog(
      {Key? key, required this.isMultiSelect, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.chooseOption.tr,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontSize: 23.sp),
            ),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: ListBody(
            children: [
              const Divider(
                height: 1,
                // color: lightGray3,
              ),
              ListTile(
                onTap: () async {
                  if (isMultiSelect) {
                    List<XFile> pickedImage = [];
                    await pickMultiImage("gallery")
                        .then((value) => pickedImage = value);

                    /// call from edit Image ***/
                    if (onTap != null && pickedImage.isNotEmpty) {
                      onTap!(pickedImage);
                    }
                  } else {
                    File pickedImage = File("");
                    await pickImage("gallery")
                        .then((value) => pickedImage = value);

                    /// call from edit Image ***/
                    if (onTap != null && pickedImage.path != "") {
                      onTap!(pickedImage);
                    }
                  }
                },
                title: Text(
                  AppStrings.gallery.tr,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontSize: 23.sp),
                ),
                leading: Icon(Icons.account_box, color: theme.primaryColor
                    //     color: black,
                    ),
              ),
              const Divider(
                height: 1,
                //  color: lightGray4,
              ),
              ListTile(
                onTap: () async {
                  if (isMultiSelect) {
                    List<XFile> pickedImage = [];
                    await pickMultiImage("camera")
                        .then((value) => pickedImage = value);

                    /// call from edit Image ***/
                    if (onTap != null && pickedImage.isNotEmpty) {
                      onTap!(pickedImage);
                    }
                  } else {
                    File pickedImage = File("");
                    await pickImage("camera")
                        .then((value) => pickedImage = value);

                    if (onTap != null && pickedImage.path != "") {
                      onTap!(pickedImage);
                    }
                  }
                },
                title: Text(
                  AppStrings.camera.tr,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontSize: 23.sp),
                ),
                leading:
                    Icon(Icons.camera_alt_outlined, color: theme.primaryColor
                        //   color: black,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
