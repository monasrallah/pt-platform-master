import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../resources/functions/pick_image_function.dart';
import '../../../resources/strings_manager.dart';

class PickPaymentMethodDialog extends StatelessWidget {
  final Function onTapCreditCard;
  final Function onTapAppPurchase;

  const PickPaymentMethodDialog(
      {Key? key, required this.onTapCreditCard, required this.onTapAppPurchase})
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
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 23.sp),
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
                  onTapCreditCard();
                },
                title: Text(
                  AppStrings.payViaCreditCard.tr,
                  style:
                      theme.textTheme.headlineMedium?.copyWith(fontSize: 23.sp),
                ),
                // leading: Icon(Icons.account_box, color: theme.primaryColor
                //     color: black,
                // ),
              ),
              const Divider(
                height: 1,
                //  color: lightGray4,
              ),
              ListTile(
                onTap: () async {
                  onTapAppPurchase();
                },
                title: Text(
                  AppStrings.payWithInAppPurchase.tr,
                  style:
                      theme.textTheme.headlineMedium?.copyWith(fontSize: 23.sp),
                ),
                // leading:
                //     Icon(Icons.camera_alt_outlined, color: theme.primaryColor
                //         //   color: black,
                //         ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
