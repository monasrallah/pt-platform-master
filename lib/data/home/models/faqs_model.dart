class AllSurveysModel {
  List<SurveyModel> surveys;

  AllSurveysModel({required this.surveys});

  factory AllSurveysModel.fromJson(Map<String, dynamic> json) {
    List<SurveyModel> all = [];
    for (var element in (json['surveys'] as List<dynamic>)) {
      all.add(SurveyModel.fromJson(element as Map<String, dynamic>));
    }
    return AllSurveysModel(surveys: all);
  }
}

class SurveyModel {
  int surveyId;
  String description;
  List<FaqsModel> questions;

  SurveyModel({
    required this.surveyId,
    required this.description,
    required this.questions,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        surveyId: json["survey_id"],
        description: json["description"],
        questions: List<FaqsModel>.from(
            json["questions"].map((x) => FaqsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "survey_id": surveyId,
        "description": description,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class AllFaqsModel {
  List<FaqsModel> faqs;

  AllFaqsModel({required this.faqs});

  factory AllFaqsModel.fromJson(Map<String, dynamic> json) {
    List<FaqsModel> all = [];
    for (var element in (json['questions'] as List<dynamic>)) {
      all.add(FaqsModel.fromJson(element as Map<String, dynamic>));
    }
    return AllFaqsModel(faqs: all);
  }
}

class FaqsModel {
  int id;
  String question;
  String? video;
  String? answer;

  FaqsModel({
    required this.id,
    required this.question,
    this.video,
    this.answer,
  });

  factory FaqsModel.fromJson(Map<String, dynamic> json) => FaqsModel(
        id: json["id"],
        question: json["question"],
        video: json["video"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };
}
