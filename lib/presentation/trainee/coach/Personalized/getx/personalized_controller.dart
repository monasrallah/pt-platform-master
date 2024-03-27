import 'package:get/get.dart';
import 'package:pt_platform/resources/strings_manager.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/routes_manager.dart';

class PersonalizedController extends GetxController {
  List<String> gridImageList = [
    ImageCoachAssets.CALENDER,
    ImageCoachAssets.VIDEOCHAT,
    ImageCoachAssets.PERSONALTRAINING,
  ];

  List<String> gridTileList = [
    AppStrings.calendar.tr,
    AppStrings.videoCall.tr,
    AppStrings.personalTraining.tr,
  ];

  List<Function> gridOnTapList = [
    () {
      Get.toNamed(Routes.calenderRoute);
    },
    () {
      Get.toNamed(Routes.videoChatRoute);
    },
    () {
      Get.toNamed(Routes.personalTrainingRoute);
    },
  ];
}
