import 'package:get/get.dart';

import 'live_chat_controller.dart';

class LiveChatCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveChatCoachController());
  }
}
