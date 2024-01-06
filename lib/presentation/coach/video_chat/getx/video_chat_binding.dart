import 'package:get/get.dart';

import 'video_chat_controller.dart';

class VideoChatCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoChatCoachController());
  }
}
