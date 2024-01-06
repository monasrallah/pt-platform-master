import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/routes_manager.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../widgets/buttons/app_back_bar.dart';
import '../../../widgets/cards/image_card.dart';
import '../getx/trainee_controller.dart';

class ChoiceActionCoachView extends GetView<TraineeCoachController> {
  const ChoiceActionCoachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.offAllNamed(Routes.coachHomeRoute);
      },
      child: Scaffold(
        appBar: appBackBar(
            title: AppStrings.trainee.tr,
            onTap: () {
              Get.offAllNamed(Routes.coachHomeRoute);
            }),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.7.sh,
          alignment: Alignment.center,
          padding: EdgeInsets.all(25.h),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: controller.gridImageList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.gridOnTapList[index](),
                child: ImageCard(
                  image: controller.gridImageList[index],
                  title: controller.gridTileList[index],
                  titleStyle:
                      Get.textTheme.displaySmall!.copyWith(fontSize: 15.sp),
                  onTap: () {},
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1,
                mainAxisSpacing: 5,
                childAspectRatio: 1.sw / 0.5.sh,
                crossAxisCount: 2),
          ),
        ),
      ],
    );
  }
}
