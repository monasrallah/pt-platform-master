import 'package:pt_platform/data/home/models/faqs_model.dart';

import '../../../domain/parameters/home_params/add_food_params.dart';
import '../../../domain/parameters/home_params/answer_questionnaire_params.dart';
import '../../../domain/parameters/home_params/filter_coaches_params.dart';
import '../../../domain/parameters/home_params/get_food_params.dart';
import '../../../domain/parameters/home_params/technical_support_params.dart';
import '../../../domain/parameters/home_params/update_measurements_params.dart';
import '../../../domain/parameters/home_params/update_progress_params.dart';
import '../../../domain/parameters/home_params/update_target_params.dart';
import '../../auth/models/coach_model.dart';
import '../../core/api_helper/app_api_helper.dart';
import '../../core/models/base_response/base_response.dart';
import '../../core/models/empty_model.dart';
import '../../core/utils/api_routes/api_routes.dart';
import '../models/banner_model.dart';
import '../models/food_model.dart';
import '../models/measurements_model.dart';
import '../models/news_model.dart';
import '../models/progress_model.dart';
import '../models/recipe_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<BaseResponse<CoachesModel>> getCoaches(
      FilterCoachesParams filterCoachesParams);

  Future<BaseResponse<EmptyModel>> technicalSupport(
      TechnicalSupportParams technicalSupportParams);

  Future<BaseResponse<EmptyModel>> feedBack(
      TechnicalSupportParams feedBackParams);

  Future<BaseResponse<AllNewsModel>> news();

  Future<BaseResponse<EmptyModel>> newsDetails(String newsId);

  Future<BaseResponse<AllMeasurementsModel>> measurements();

  Future<BaseResponse<EmptyModel>> updateMeasurements(
      UpdateMeasurementsParams updateMeasurementsParams);

  Future<BaseResponse<AllProgressModel>> progress();

  Future<BaseResponse<EmptyModel>> updateProgress(
      UpdateProgressParams updateProgressParams);

  Future<BaseResponse<AllFaqsModel>> faqs();

  Future<BaseResponse<AllSurveysModel>> questionnaire();

  Future<BaseResponse<EmptyModel>> answerQuestionnaire(
      AnswerQuestionnaireParams answerQuestionnaireParams);

  Future<BaseResponse<AllRecipeModel>> recipes(String name);

  Future<BaseResponse<AllSupplementsModel>> supplements(String name);

  Future<BaseResponse<EmptyModel>> getTarget();

  Future<BaseResponse<EmptyModel>> updateTarget(
      UpdateTargetParams updateTargetParams);

  Future<BaseResponse<FoodModel>> getFoodHistory(String dateTime);

  Future<BaseResponse<AllAddFoodModel>> getFood(GetFoodsParams getFoodsParams);

  Future<BaseResponse<EmptyModel>> addFood(AddFoodsParams addFoodsParams);

  Future<BaseResponse<EmptyModel>> deleteFood(int foodId);

  Future<BaseResponse<AllBannerModel>> getBanner(String? id);
}

class HomeRemoteDataSourceImpl implements BaseHomeRemoteDataSource {
  final AppApiHelper _appApiHelper;

  HomeRemoteDataSourceImpl(this._appApiHelper);

  @override
  Future<BaseResponse<EmptyModel>> addFood(AddFoodsParams addFoodsParam) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.addFood, addFoodsParam.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> answerQuestionnaire(
      AnswerQuestionnaireParams answerQuestionnaireParams) async {
    // var data = answerQuestionnaireParams.toJson();
    final data = answerQuestionnaireParams.toJson();
    data.removeWhere((key, value) => value == null || value == '');


    return await _appApiHelper.performPostRequest(
        AppUrls.answerQuestionnaire, data, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllFaqsModel>> faqs() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.faqs, AllFaqsModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> feedBack(
      TechnicalSupportParams feedBackParams) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.feedbackUrl, feedBackParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllBannerModel>> getBanner(String? id) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getBannerUrl, AllBannerModel.fromJson,
        queryParameters: id != null ? {"user_id": id} : null);
  }

  @override
  Future<BaseResponse<CoachesModel>> getCoaches(
      FilterCoachesParams filterCoachesParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.getCoachesUrl,
        filterCoachesParams.toJson(), CoachesModel.fromJson);
  }

  @override
  Future<BaseResponse<AllAddFoodModel>> getFood(
      GetFoodsParams getFoodsParams) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getFood, AllAddFoodModel.fromJson,
        queryParameters: getFoodsParams.toJson());
  }

  @override
  Future<BaseResponse<FoodModel>> getFoodHistory(String dateTime) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getFoodHistory, FoodModel.fromJson,
        queryParameters: {"date": dateTime});
  }

  @override
  Future<BaseResponse<EmptyModel>> getTarget() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getTarget, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllMeasurementsModel>> measurements() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.measurements, AllMeasurementsModel.fromJson);
  }

  @override
  Future<BaseResponse<AllNewsModel>> news() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.newsFeed, AllNewsModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> newsDetails(String newsId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.newsDetails(newsId), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllProgressModel>> progress() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.progress, AllProgressModel.fromJson);
  }

  @override
  Future<BaseResponse<AllSurveysModel>> questionnaire() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.questionnaire, AllSurveysModel.fromJson);
  }

  @override
  Future<BaseResponse<AllRecipeModel>> recipes(String name) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.recipes, AllRecipeModel.fromJson,
        queryParameters: {"name": name});
  }

  @override
  Future<BaseResponse<AllSupplementsModel>> supplements(String name) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.supplements, AllSupplementsModel.fromJson,
        queryParameters: {"title": name});
  }

  @override
  Future<BaseResponse<EmptyModel>> technicalSupport(
      TechnicalSupportParams technicalSupportParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.technicalSupportUrl,
        technicalSupportParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> updateMeasurements(
      UpdateMeasurementsParams updateMeasurementsParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.measurements,
        updateMeasurementsParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> updateProgress(
      UpdateProgressParams updateProgressParams) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.progress, updateProgressParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> updateTarget(
      UpdateTargetParams updateTargetParams) async {
    return await _appApiHelper.performPostRequest(
        AppUrls.getTarget, updateTargetParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> deleteFood(int foodId) async {
    return await _appApiHelper.performDeleteRequest(
        "${AppUrls.addFood}/$foodId",
        fromJson: EmptyModel.fromJson);
  }
}
