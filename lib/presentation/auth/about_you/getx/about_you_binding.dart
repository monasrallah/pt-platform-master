import 'package:get/get.dart';
import 'package:pt_platform/presentation/auth/about_you/getx/about_you_controller.dart';

class AboutYouBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutYouController());
  }
}
