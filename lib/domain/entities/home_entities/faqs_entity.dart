class SurveyEntity {
  int surveyId;
  String description;
  List<FaqsEntity> questions;

  SurveyEntity({
    required this.surveyId,
    required this.description,
    required this.questions,
  });
}

class FaqsEntity {
  int id;
  String question;
  String? video;
  String answer;

  FaqsEntity({
    required this.id,
    required this.question,
    this.video,
    required this.answer,
  });

  factory FaqsEntity.copyWith(FaqsEntity faqsEntity) {
    return FaqsEntity(
        id: faqsEntity.id,
        question: faqsEntity.question,
        answer: faqsEntity.answer);
  }
}
