import 'package:get/get.dart';

import 'questionnaire_controller.dart';

class QuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionnaireController());
  }
}
