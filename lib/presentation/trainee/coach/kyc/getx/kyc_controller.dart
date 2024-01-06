import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/faqs_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/home_params/answer_questionnaire_params.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/coach_controller.dart';

class KycController extends GetxController {
  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  RxList<FaqsEntity> kyc = <FaqsEntity>[].obs;

  getKyc() async {
    isLoading = true;
    (await baseCoachRepository.kyc(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<FaqsEntity> data) => {kyc.value = data});
    isLoading = false;
  }

  List<QuestionnaireParams> questionnaire = [];

  List<QuestionnaireParams> convertEntityToParams() {
    kyc
        .map((element) => questionnaire.add(QuestionnaireParams(
            question_id: element.id, answer: element.answer)))
        .toList();
    return questionnaire;
  }

  answerKyc() async {
    isLoading = true;
    (await baseCoachRepository.saveAnswerKyc(AnswerQuestionnaireParams(
            coachId: Get.find<CoachController>().coachId.value,
            questionnaire: convertEntityToParams())))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) async => {await getKyc()});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getKyc();
    super.onInit();
  }
}
