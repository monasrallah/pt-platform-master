class AppUrls {
  static const String domain = "https://ptplatform.smartedge.me/public/";

  static const String baseUrl = "${domain}api/v1";

  static const String storageUrl = "https://ptplatform.smartedge.me/";

  /// users
  static const String baseUserUrl = "/users/";
  static const String baseUserCoachUrl = "${baseUserUrl}coaches";

  ///todo add get profile route
  static const String getProfileUrl = "${baseUserUrl}get-profile";
  static const String turnNotificationUrl =
      "${baseUserUrl}update/notifications";
  static const String getAssignedCoachesUrl =
      "$baseUserCoachUrl?filter=assigned_coaches";
  static const String changePasswordUrl = "${baseUserUrl}update/password";
  static const String editProfileImageUrl = "${baseUserUrl}update/avatar";
  static const String editProfileNameUrl = "${baseUserUrl}update/name";
  static const String deleteAccountUrl = "${baseUserUrl}delete-account";

  /// auth
  static const String baseAuthUrl = "/auth/";
  static const String getAllCategoriesUrl = "${baseAuthUrl}all-categories";
  static const String loginUrl = "${baseAuthUrl}login";
  static const String logoutUrl = "/users/logout";
  static const String registerTraineeUrl = "${baseAuthUrl}register-user";
  static const String registerCoachUrl = "${baseAuthUrl}register-coach";
  static const String resetCodeUrl = "${baseAuthUrl}verify-email/reset-code";
  static const String checkCodeUrl = "${baseAuthUrl}verify-email/check-code";
  static const String sendEmailForgetUrl =
      "${baseAuthUrl}verify-email/forgot-password";
  static const String sendEmailRegisterUrl = "${baseAuthUrl}verify-email";
  static const String resetPasswordUrl =
      "${baseAuthUrl}verify-email/update-password";

  /// home
  static const String getBannerUrl = "/banners";

  static const String getCoachesUrl = "$baseUserCoachUrl?name=search";

  static const String technicalSupportUrl = "/ticket/technical_support";

  static const String feedbackUrl = "/ticket/feedback";

  static const String newsFeed = "/news-feed";

  static String newsDetails(String newsId) => "$newsFeed/$newsId/show";

  static const String measurements = "/body-measurements";

  static const String progress = "/healths";

  static const String faqs = "/faqs";

  static const String questionnaire = "/questionnaire";

  static const String answerQuestionnaire = "/questionnaire/answer";

  static const String recipes = "/recipes";

  static const String supplements = "/supplements";

  static const String getTarget = "$baseUserUrl/target";

  static const String getFoodHistory = "/foods/user";

  static const String getFood = "/foods";

  static const String addFood = "/foods/user";

  /// coach screen
  /// kyc
  static const String kycUrl = "/coach-questions";

  /// challenge
  static const String challengesUrl = "/challenges";
  static const String challengeVideoUrl = "/challenges/videos";
  static const String completeVideoUrl = "/challenges/complete";

  /// Favourites
  static const String videoFavouritesUrl = "/video-favourites";

  /// Workout
  static const String videoWorkoutUrl = "/video-workout";
  static const String videoLogsUrl = "/video-logs/{exercise_video}/store";

  ///Exercise
  static const String baseSectionExerciseUrl = "/section-exercise";
  static const String exerciseUrl = "$baseSectionExerciseUrl/exercises";
  static const String exerciseVideosUrl = "$baseSectionExerciseUrl/videos";

  ///Section
  static const String baseSectionWorkoutUrl = "/section-workout";
  static const String workoutUrl = "$baseSectionWorkoutUrl/exercises";
  static const String workoutVideosUrl = "$baseSectionWorkoutUrl/videos";

  /// calender
  static const String coachCalendarUrl = "/coach-calendar";
  static const String addCalendarUrl = "$coachCalendarUrl/reservation";

  /// video chat
  static const String getVideoChatUrl = "$coachCalendarUrl/user";
  static const String deleteVideoChatUrl =
      "$coachCalendarUrl/delete-reservation";

  /// personal training
  static const String baseAssignedWorkoutUrl = "/users/training/";
  static const String getAssignedWorkoutUrl =
      "${baseAssignedWorkoutUrl}workout";

  static String getPersonalTrainingVideoUrl(int id) =>
      "/users/training/workout/$id/show";

  static const String getAssignedMealsUrl = "${baseAssignedWorkoutUrl}recipe";

  static const String getPersonalisedUrl = "${baseAssignedWorkoutUrl}personal";

  //shop
  static const String baseShopUrl = "/packages";
  static const String tipsShopUrl = "/packages/tips-store-payment";
  static const String tipsUrl = "$baseShopUrl/tips";
  static const String promoCodeCheckUrl = "/promo-code/check";

  /// history
  static const String exerciseHistory = "/video-logs";

  static String exerciseLogs(int id) => "/video-logs/$id/show?type=exercise";

  /// Coach Application

  /// personal training
  static const String basePersonalTrainingUrl = "/coaches/personal-training";
  static const String getMyPersonalTrainingUrl =
      "$basePersonalTrainingUrl?name=choose me";

  static String kycCoachUrl(String id) => "/coach-questions/$id/by-user";

  static const String calenderCoachUrl = "/coach-calendar/calendar";
  static const String videoChatCoachUrl = "/coach-calendar/coach";
}
