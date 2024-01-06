import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../../../domain/parameters/home_params/answer_questionnaire_params.dart';
import '../../../../widgets/toasts_messages.dart';

class QuestionnaireController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<SurveyEntity> questionnaire = [];

  getQuestionnaire() async {
    isLoading = true;
    (await baseHomeRepository.questionnaire()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<SurveyEntity> data) => {questionnaire = data});
    isLoading = false;
  }

  List<QuestionnaireParams> questionnaireParams = [];

  List<QuestionnaireParams> convertEntityToParams(index) {
    questionnaireParams.clear();
    questionnaire[index]
        .questions
        .map((element) => questionnaireParams.add(QuestionnaireParams(
            question_id: element.id, answer: element.answer)))
        .toList();
    return questionnaireParams;
  }

  answerQuestionnaire(index) async {
    isLoading = true;
    (await baseHomeRepository.answerQuestionnaire(AnswerQuestionnaireParams(
            questionnaire: convertEntityToParams(index))))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {Get.back()});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getQuestionnaire();
    super.onInit();
  }
}
