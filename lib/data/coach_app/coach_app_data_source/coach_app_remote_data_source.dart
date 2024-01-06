import '../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../../domain/parameters/coach_params/date_coach_id_params.dart';
import '../../coach/models/challenge_model.dart';
import '../../coach/models/chat_model.dart';
import '../../coach/models/exercise_log_model.dart';
import '../../coach/models/section_exercise_model.dart';
import '../../coach/models/video_model.dart';
import '../../core/api_helper/app_api_helper.dart';
import '../../core/models/base_response/base_response.dart';
import '../../core/utils/api_routes/api_routes.dart';
import '../../home/models/banner_model.dart';
import '../../home/models/faqs_model.dart';
import '../../home/models/food_model.dart';
import '../../home/models/measurements_model.dart';
import '../../home/models/progress_model.dart';
import '../models/calender_model.dart';
import '../models/user_model.dart';

abstract class BaseCoachAppRemoteDataSource {
  Future<BaseResponse<AllBannerModel>> getBanner(int? id);

  Future<BaseResponse<AllUsersModel>> getUsers(String? search);

  // trainee
  Future<BaseResponse<AllFaqsModel>> kyc(String userId);

  Future<BaseResponse<AllChallengesModel>> getChallenges(String coachId);

  Future<BaseResponse<AllChallengesVideoModel>> challengeVideo(
      ChallengeVideoParams challengeVideoParams);

  Future<BaseResponse<AllExerciseLogsModel>> getExerciseLogs(int exerciseLogs);

  Future<BaseResponse<AllVideoModel>> getExerciseHistory(
      String userId, String coachId);

  // Exercise
  Future<BaseResponse<AllSectionModel>> getSectionExercise(String coachId);

  Future<BaseResponse<AllExercisesModel>> getExercise(
      String coachId, String search);

  Future<BaseResponse<AllVideoModel>> getExerciseVideo(
      String coachId, int exerciseId);

  //WorkOut
  Future<BaseResponse<AllSectionModel>> getSectionWorkOut(String coachId);

  Future<BaseResponse<AllExercisesModel>> getWorkOut(
      String coachId, String search);

  Future<BaseResponse<AllVideoModel>> getWorkOutVideo(
      String coachId, int exerciseId);

  /// PersonalTraining
  Future<BaseResponse<AllVideoModel>> getPersonalTrainingVideo(
      String coachId, int workoutId);

  // calender
  Future<BaseResponse<AllCalendersCoachModel>> getCoachCalendar();

  // video chat
  Future<BaseResponse<AllChatsModel>> getVideoChat(String coachId);

  Future<BaseResponse<AllMeasurementsModel>> measurements(String userId);

  Future<BaseResponse<AllProgressModel>> progress(String userId);

  Future<BaseResponse<FoodModel>> getFoodHistory(
      String dateTime, String userId);

// Future<BaseResponse<EmptyModel>> saveAnswerKyc(
//     AnswerQuestionnaireParams answerQuestionnaireParams);
//
// Future<BaseResponse<AllVideoModel>> getFavorite(String coachId);
//
// Future<BaseResponse<AllVideoModel>> getTodayWorksOut(String coachId);
//
// Future<BaseResponse<EmptyModel>> completeChallengeVideo(
//     CompleteChallengeVideoParams completeChallengeVideoParams);
//
// Future<BaseResponse<EmptyModel>> addFavouriteVideo(
//     VideouserIdParams videouserIdParams);
//
// Future<BaseResponse<EmptyModel>> addTodayWorkOutVideo(
//     VideouserIdParams videouserIdParams);
//
// Future<BaseResponse<EmptyModel>> addToLogVideo(
//     AddVideoToLogParams addVideoToLogParams);
//
// Future<BaseResponse<EmptyModel>> addCoachCalendar(
//     AddCalenderParams addCalenderParams);
//
// Future<BaseResponse<EmptyModel>> deleteVideoChat(int id);
//
// Future<BaseResponse<AllAssignedWorkoutsModel>> getAssignedWorkout(
//     String coachId);
//
// Future<BaseResponse<AllAssignedMealsModel>> getAssignedMeals(String coachId);
//
//
// Future<BaseResponse<PersonalizedModel>> getPersonalized(String coachId);
//
// Future<BaseResponse<ShopModel>> getShop(String coachId);
//
// Future<BaseResponse<TipsModel>> getTips(String coachId);
//
// Future<BaseResponse<EmptyModel>> checkout(
//     PackagePaymentParams packagePaymentParams);
//
// Future<BaseResponse<EmptyModel>> checkoutTips(
//     TipsPaymentParams packagePaymentParams);
//
// Future<BaseResponse<EmptyModel>> checkPromoCode(
//     CheckPromoCodeParams checkPromoCodeParams);
}

class CoachAppRemoteDataSourceImpl implements BaseCoachAppRemoteDataSource {
  final AppApiHelper _appApiHelper;

  CoachAppRemoteDataSourceImpl(this._appApiHelper);

  @override
  Future<BaseResponse<AllBannerModel>> getBanner(int? id) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getBannerUrl, AllBannerModel.fromJson,
        queryParameters: id != null ? {"user_id": id} : null);
  }

  @override
  Future<BaseResponse<AllUsersModel>> getUsers(String? search) async {
    return await _appApiHelper.performGetRequest(
      AppUrls.basePersonalTrainingUrl, AllUsersModel.fromJson,
      queryParameters: {/*"name": "choose me",*/ "name": search}
    );
  }

  @override
  Future<BaseResponse<AllFaqsModel>> kyc(String userId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.kycCoachUrl(userId), AllFaqsModel.fromJson);
  }

  @override
  Future<BaseResponse<AllChallengesModel>> getChallenges(String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.challengesUrl, AllChallengesModel.fromJson,
        queryParameters: {"user_id": coachId});
  }

  @override
  Future<BaseResponse<AllChallengesVideoModel>> challengeVideo(
      ChallengeVideoParams challengeVideoParams) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.challengeVideoUrl, AllChallengesVideoModel.fromJson,
        queryParameters: challengeVideoParams.toJson());
  }

  @override
  Future<BaseResponse<AllExercisesModel>> getExercise(
      String coachId, String search) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseUrl, AllExercisesModel.fromJson,
        queryParameters: {"user_id": coachId, "search": search});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getExerciseVideo(
      String coachId, int exerciseId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseVideosUrl, AllVideoModel.fromJson,
        queryParameters: {"user_id": coachId, "exercise_id": exerciseId});
  }

  @override
  Future<BaseResponse<AllSectionModel>> getSectionExercise(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.baseSectionExerciseUrl, AllSectionModel.fromJson,
        queryParameters: {"user_id": coachId});
  }

  @override
  Future<BaseResponse<AllSectionModel>> getSectionWorkOut(
      String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.baseSectionWorkoutUrl, AllSectionModel.fromJson,
        queryParameters: {"user_id": coachId});
  }

  @override
  Future<BaseResponse<AllExercisesModel>> getWorkOut(
      String coachId, String search) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.workoutUrl, AllExercisesModel.fromJson,
        queryParameters: {"user_id": coachId, "search": search});
  }

  @override
  Future<BaseResponse<AllVideoModel>> getWorkOutVideo(
      String coachId, int exerciseId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.workoutVideosUrl, AllVideoModel.fromJson,
        queryParameters: {"user_id": coachId, "exercise_id": exerciseId});
  }

  @override
  Future<BaseResponse<AllCalendersCoachModel>> getCoachCalendar() async {
    return await _appApiHelper.performGetRequest(
        AppUrls.calenderCoachUrl, AllCalendersCoachModel.fromJson);
  }

  @override
  Future<BaseResponse<AllChatsModel>> getVideoChat(String coachId) async {
    return await _appApiHelper.performGetRequest(
      AppUrls.videoChatCoachUrl, AllChatsModel.fromJson,
      // queryParameters: {"user_id": coachId}
    );
  }

  @override
  Future<BaseResponse<AllVideoModel>> getPersonalTrainingVideo(
      String coachId, int workoutId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getPersonalTrainingVideoUrl(workoutId), AllVideoModel.fromJson,
        queryParameters: {"user_id": coachId});
  }

  @override
  Future<BaseResponse<AllExerciseLogsModel>> getExerciseLogs(
      int exerciseLogs) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseLogs(exerciseLogs), AllExerciseLogsModel.fromJson);
  }

  @override
  Future<BaseResponse<AllVideoModel>> getExerciseHistory(
      String userId, String coachId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.exerciseHistory, AllVideoModel.fromJson,
        queryParameters: {"user_id": userId, "coach_id": coachId});
  }

  @override
  Future<BaseResponse<AllMeasurementsModel>> measurements(String userId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.measurements, AllMeasurementsModel.fromJson,
        queryParameters: {"user_id": userId});
  }

  @override
  Future<BaseResponse<AllProgressModel>> progress(String userId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.progress, AllProgressModel.fromJson,
        queryParameters: {"user_id": userId});
  }

  @override
  Future<BaseResponse<FoodModel>> getFoodHistory(
      String dateTime, String userId) async {
    return await _appApiHelper.performGetRequest(
        AppUrls.getFoodHistory, FoodModel.fromJson,
        queryParameters: {"date": dateTime, "user_id": userId});
  }
}
