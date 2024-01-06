import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../domain/entities/auth_entities/coach_entity.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/dialogs/coach_info_dialog.dart';

class TrainerCard extends StatelessWidget {
  const TrainerCard({required this.coach, Key? key}) : super(key: key);
  final CoachEntity coach;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          Column(
            children: [
              10.verticalSpace,
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 250.h,
                  child: Image.network(
                    coach.avatar != null
                        ? coach.avatar!
                        : Get.find<AppController>().defaultImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              10.verticalSpace,
              Expanded(
                flex: 1,
                child: Text(
                  coach.lastName.orEmpty(),
                  style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.dialog(InformationDialog(
                header: AppStrings.coachInformation.tr,
                coachName: coach.lastName.orEmpty(),
                coachCategory: coach.categories!.map((e) => e.name).toList(),
                coachDesc: coach.description.orEmpty(),
              ));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
