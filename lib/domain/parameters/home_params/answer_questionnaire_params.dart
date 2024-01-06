class AnswerQuestionnaireParams {
  String? coachId;
  List<QuestionnaireParams> questionnaire;

  AnswerQuestionnaireParams({this.coachId, required this.questionnaire});

  Map<String, dynamic> toJson() => {
        "coach_id": coachId ?? "",
        "answers": questionnaire.map((e) => e.toJson()).toList(),
      };
}

class QuestionnaireParams {
  int question_id;
  String answer;

  QuestionnaireParams({required this.question_id, required this.answer});

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "question_id": question_id,
      };
}
