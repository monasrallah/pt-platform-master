import 'package:get/get.dart';
import 'package:pt_platform/presentation/coach/trainee/getx/trainee_controller.dart';

class TraineeCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TraineeCoachController());
  }
}
