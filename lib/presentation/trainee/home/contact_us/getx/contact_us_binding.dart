import 'package:get/get.dart';

import '../../follow_us/getx/follow_us_controller.dart';
import 'contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }
}
