import 'package:get/get.dart';

import 'live_chat_controller.dart';

class LiveChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LiveChatController());
  }
}