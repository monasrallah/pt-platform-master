import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';

import '../../../../../domain/entities/coach_entities/personalized_entity.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/dialogs/pick_payment_method_dialog.dart';
import '../../getx/coach_controller.dart';

class TipsCard extends GetView<CoachController> {
  const TipsCard({required this.image, Key? key, required this.tip})
      : super(key: key);
  final String image;
  final DataEntity tip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 0.5.sw,
          height: 0.16.sh,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        PositionedDirectional(
          top: 0.04.sh,
          end: 1.w,
          start: 1.w,
          child: SizedBox(
            width: 0.5.sw,
            child: Text(
              "${tip.value} usd",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge!.copyWith(fontSize: 30.sp),
            ),
          ),
        ),
        PositionedDirectional(
          top: 0.1.sh,
          end: 1.w,
          start: 1.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomElevatedButton(
              width: 0.35.sw,
              height: 40.h,
              title: AppStrings.buyNow.tr,
              elevation: 0,
              textStyle: Get.textTheme.bodySmall,
              // backgroundColor: Colors.grey.withOpacity(0.5),
              // backgroundColor: Colors.yellow.withOpacity(0.3),
              backgroundColor: Colors.redAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(22.r),
              onTap: () {
                controller.checkout(tip.id, "stripe");
                // Get.dialog(PickPaymentMethodDialog(
                //   onTapCreditCard: () => controller.checkout(tip.id, "stripe"),
                //   onTapAppPurchase: () =>
                //       controller.checkout(tip.id, "purchase"),
                // ));
                // return ;
              },
            ),
          ),
        ),
      ],
    );
  }
}
