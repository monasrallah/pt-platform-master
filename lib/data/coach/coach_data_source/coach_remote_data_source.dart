import 'package:pt_platform/domain/parameters/home_params/answer_questionnaire_params.dart';
import 'package:pt_platform/resources/functions/date_format_function.dart';

import '../../../domain/parameters/coach_params/add_calender_params.dart';
import '../../../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../../domain/parameters/coach_params/check_promo_code_params.dart';
import '../../../domain/parameters/coach_params/complete_challenge_video_params.dart';
import '../../../domain/parameters/coach_params/date_coach_id_params.dart';
import '../../../domain/parameters/coach_params/packege_payment_params.dart';
import '../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../core/api_helper/app_api_helper.dart';
import '../../core/models/base_response/base_response.dart';
import '../../core/models/empty_model.dart';
import '../../core/utils/api_routes/api_routes.dart';
import '../../home/models/faqs_model.dart';
import '../models/calender_model.dart';
import '../models/challenge_model.dart';
import '../models/chat_model.dart';
import '../models/exercise_log_model.dart';
import '../models/personal_training_model.dart';
import '../models/section_exercise_model.dart';
import '../models/shop_model.dart';
import '../models/video_model.dart';

abstract class BaseCoachRemoteDataSource {
  Future<BaseResponse<AllFaqsModel>> kyc(String coachId);

  Future<BaseResponse<EmptyModel>> saveAnswerKyc(
      AnswerQuestionnaireParams answerQuestionnaireParams);

  Future<BaseResponse<AllChallengesModel>> getChallenges(String coachId);

  Future<BaseResponse<AllVideoModel>> getFavorite(String coachId);

  Future<BaseResponse<AllVideoModel>> getTodayWorksOut(String coachId);

  Future<BaseResponse<AllChallengesVideoModel>> challengeVideo(
      ChallengeVideoParams challengeVideoParams);

  Future<BaseResponse<EmptyModel>> completeChallengeVideo(
      CompleteChallengeVideoParams completeChallengeVideoParams);

  Future<BaseResponse<AllSectionModel>> getSectionExercise(String coachId);

  Future<BaseResponse<AllExercisesModel>> getExercise(
      String coachId, String search);

  Future<BaseResponse<AllVideoModel>> getExerciseVideo(
      String coachId, int exerciseId);

  Future<BaseResponse<EmptyModel>> addFavouriteVideo(
      VideoCoachIdParams videoCoachIdParams);

  Future<BaseResponse<EmptyModel>> addTodayWorkOutVideo(
      VideoCoachIdParams videoCoachIdParams);

  Future<BaseResponse<EmptyModel>> addToLogVideo(
      AddVideoToLogParams addVideoToLogParams);

  Future<BaseResponse<AllSectionModel>> getSectionWorkOut(String coachId);

  Future<BaseResponse<AllExercisesModel>> getWorkOut(
      String coachId, String search);

  Future<BaseResponse<AllVideoModel>> getWorkOutVideo(
      String coachId, int exerciseId);

  Future<BaseResponse<AllCalendersModel>> getCoachCalendar(
      DateCoachIdParams dateCoachIdParams);

  Future<BaseResponse<EmptyModel>> addCoachCalendar(
      AddCalenderParams addCalenderParams);

  Future<BaseResponse<AllChatsModel>> getVideoChat(String coachId);

  Future<BaseResponse<EmptyModel>> deleteVideoChat(int id);

  Future<BaseResponse<AllAssignedWorkoutsModel>> getAssignedWorkout(
      String coachId);

  Future<BaseResponse<AllAssignedMealsModel>> getAssignedMeals(String coachId);

  Future<BaseResponse<AllVideoModel>> getPersonalTrainingVideo(
      String coachId, int workoutId);

  Future<BaseResponse<PersonalizedModel>> getPersonalized(String coachId);

  Future<BaseResponse<ShopModel>> getShop(String coachId);

  Future<BaseResponse<TipsModel>> getTips(String coachId);

  Future<BaseResponse<StripeModel>> checkout(
      PackagePaymentParams packagePaymentParams);

  Future<BaseResponse<EmptyModel>> checkoutFree(
      PackagePaymentParams packagePaymentParams);

  Future<BaseResponse<StripeModel>> checkoutTips(
      TipsPaymentParams packagePaymentParams);

  Future<BaseResponse<DiscountModel>> checkPromoCode(
      CheckPromoCodeParams checkPromoCodeParams);

  Future<BaseResponse<AllExerciseLogsModel>> getExerciseLogs(
      int exerciseLogs, String? userId, String coachId);

  Future<BaseResponse<AllVideoModel>> getExerciseHistory(String coachId);
}

class CoachRemoteDataSourceImpl implements BaseCoachRemoteDataSource {
  final AppApiHelper _appApiHelper;

  CoachRemoteDataSourceImpl(this._appApiHelper);

  @override
  Future<BaseResponse<AllFaqsModel>> kyc(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.kycUrl, AllFaqsModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<EmptyModel>> saveAnswerKyc(
      AnswerQuestionnaireParams answerQuestionnaireParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.kycUrl,
        answerQuestionnaireParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllChallengesModel>> getChallenges(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.challengesUrl, AllChallengesModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllChallengesVideoModel>> challengeVideo(
      ChallengeVideoParams challengeVideoParams) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.challengeVideoUrl, AllChallengesVideoModel.fromJson,
        queryParameters: challengeVideoParams.toJson());
  }

  @override
  Future<BaseResponse<EmptyModel>> completeChallengeVideo(
      CompleteChallengeVideoParams completeChallengeVideoParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.completeVideoUrl,
        completeChallengeVideoParams.toJson(), EmptyModel.fromJson,
        queryParameters: {"coach_id": completeChallengeVideoParams.coachId});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getFavorite(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.videoFavouritesUrl, AllVideoModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getTodayWorksOut(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.videoWorkoutUrl, AllVideoModel.fromJson, queryParameters: {
      "coach_id": coachId,
      "date": dateFormat(date: DateTime.now())
    });
  }

  @override
  Future<BaseResponse<EmptyModel>> addFavouriteVideo(
      VideoCoachIdParams videoCoachIdParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.videoFavouritesUrl,
        videoCoachIdParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> addToLogVideo(
      AddVideoToLogParams addVideoToLogParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.videoLogsUrl,
        addVideoToLogParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> addTodayWorkOutVideo(
      VideoCoachIdParams videoCoachIdParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.videoWorkoutUrl,
        videoCoachIdParams.toJson(), EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<AllExercisesModel>> getExercise(
      String coachId, String search) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseUrl, AllExercisesModel.fromJson,
        queryParameters: {"coach_id": coachId, "search": search});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getExerciseVideo(
      String coachId, int exerciseId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseVideosUrl, AllVideoModel.fromJson,
        queryParameters: {"coach_id": coachId, "exercise_id": exerciseId});
  }

  @override
  Future<BaseResponse<AllSectionModel>> getSectionExercise(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.baseSectionExerciseUrl, AllSectionModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllSectionModel>> getSectionWorkOut(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.baseSectionWorkoutUrl, AllSectionModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllExercisesModel>> getWorkOut(
      String coachId, String search) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.workoutUrl, AllExercisesModel.fromJson,
        queryParameters: {"coach_id": coachId, "search": search});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getWorkOutVideo(
      String coachId, int exerciseId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.workoutVideosUrl, AllVideoModel.fromJson,
        queryParameters: {"coach_id": coachId, "exercise_id": exerciseId});
  }

  @override
  Future<BaseResponse<EmptyModel>> addCoachCalendar(
      AddCalenderParams addCalenderParams) async {
    return await _appApiHelper.performPostRequest(
      AppUrls.addCalendarUrl,
      addCalenderParams.toJson(),
      EmptyModel.fromJson,
    );
  }

  @override
  Future<BaseResponse<AllCalendersModel>> getCoachCalendar(
      DateCoachIdParams dateCoachIdParams) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.coachCalendarUrl, AllCalendersModel.fromJson,
        queryParameters: dateCoachIdParams.toJson());
  }

  @override
  Future<BaseResponse<EmptyModel>> deleteVideoChat(int id) async {
    return await _appApiHelper.performDeleteRequest(
      AppUrls.deleteVideoChatUrl,
      queryParameters: {"id": id},
      fromJson: EmptyModel.fromJson,
    );
  }

  @override
  Future<BaseResponse<AllChatsModel>> getVideoChat(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getVideoChatUrl, AllChatsModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllAssignedMealsModel>> getAssignedMeals(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getAssignedMealsUrl, AllAssignedMealsModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllAssignedWorkoutsModel>> getAssignedWorkout(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getAssignedWorkoutUrl, AllAssignedWorkoutsModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getPersonalTrainingVideo(
      String coachId, int workoutId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getPersonalTrainingVideoUrl(workoutId), AllVideoModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<PersonalizedModel>> getPersonalized(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getPersonalisedUrl, PersonalizedModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<ShopModel>> getShop(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.baseShopUrl, ShopModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<TipsModel>> getTips(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.tipsUrl, TipsModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }

  @override
  Future<BaseResponse<StripeModel>> checkout(
      PackagePaymentParams packagePaymentParams) async {
    final data = packagePaymentParams.toJson();
    data.removeWhere((key, value) => value == null || value == '');
    return await _appApiHelper.performPostRequest(
        AppUrls.baseShopUrl, data, StripeModel.fromJson);
  }

  @override
  Future<BaseResponse<EmptyModel>> checkoutFree(
      PackagePaymentParams packagePaymentParams) async {
    final data = packagePaymentParams.toJson();
    data.removeWhere((key, value) => value == null || value == '');
    return await _appApiHelper.performPostRequest(
        AppUrls.baseShopUrl, data, EmptyModel.fromJson);
  }

  @override
  Future<BaseResponse<StripeModel>> checkoutTips(
      TipsPaymentParams packagePaymentParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.tipsShopUrl,
        packagePaymentParams.toJson(), StripeModel.fromJson);
  }

  @override
  Future<BaseResponse<DiscountModel>> checkPromoCode(
      CheckPromoCodeParams checkPromoCodeParams) async {
    return await _appApiHelper.performPostRequest(AppUrls.promoCodeCheckUrl,
        checkPromoCodeParams.toJson(), DiscountModel.fromJson);
  }

  @override
  Future<BaseResponse<AllExerciseLogsModel>> getExerciseLogs(
      int exerciseLogs, String? userId, String coachId) async {
    print("coachId $coachId");
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseLogs(exerciseLogs, null, coachId),
        AllExerciseLogsModel.fromJson);
  }

  @override
  Future<BaseResponse<AllVideoModel>> getExerciseHistory(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseHistory, AllVideoModel.fromJson,
        queryParameters: {"coach_id": coachId});
  }
}
