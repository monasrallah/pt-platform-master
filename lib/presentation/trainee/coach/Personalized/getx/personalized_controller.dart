import 'package:get/get.dart';

import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/routes_manager.dart';

class PersonalizedController extends GetxController {
  List<String> gridImageList = [
    ImageCoachAssets.CALENDER,
    ImageCoachAssets.VIDEOCHAT,
    ImageCoachAssets.PERSONALTRAINING,
  ];

  List<String> gridTileList = [
    'Calendar',
    "Video Call",
    "Personal Training",
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
