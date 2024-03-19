import 'package:get/get.dart';
import 'package:pt_platform/presentation/auth/verfied_email/getx/verified_email_binding.dart';
import 'package:pt_platform/presentation/auth/verfied_email/verified_email_view.dart';
import 'package:pt_platform/presentation/trainee/home/faqs/faqs_view.dart';
import 'package:pt_platform/presentation/trainee/home/faqs/getx/faqs_binding.dart';
import 'package:pt_platform/presentation/trainee/home/questionnaire/survey_view.dart';

import '../presentation/auth/about_you/about_you_view.dart';
import '../presentation/auth/about_you/getx/about_you_binding.dart';
import '../presentation/auth/forget_password/forget_password_view.dart';
import '../presentation/auth/forget_password/getx/forget_password_binding.dart';
import '../presentation/auth/login/getx/login_biniding.dart';
import '../presentation/auth/login/login_view.dart';
import '../presentation/auth/otp/getx/otp_binding.dart';
import '../presentation/auth/otp/otp_view.dart';
import '../presentation/auth/register/getx/register_biniding.dart';
import '../presentation/auth/register/register_view.dart';
import '../presentation/auth/reset_password/getx/reset_password_binding.dart';
import '../presentation/auth/reset_password/reset_password_view.dart';
import '../presentation/coach/calender/calender_view.dart';
import '../presentation/coach/calender/getx/calender_binding.dart';
import '../presentation/coach/coach_home_view.dart';
import '../presentation/coach/exercises/exercises_view.dart';
import '../presentation/coach/exercises/getx/exercises_binding.dart';
import '../presentation/coach/getx/coach_home_binding.dart';
import '../presentation/coach/personal_training/getx/personal_training_binding.dart';
import '../presentation/coach/personal_training/personal_training_view.dart';
import '../presentation/coach/trainee/challenge/challenge_view.dart';
import '../presentation/coach/trainee/challenge/getx/challenge_binding.dart';
import '../presentation/coach/trainee/getx/trainee_coach_binding.dart';
import '../presentation/coach/trainee/kyc/getx/kyc_binding.dart';
import '../presentation/coach/trainee/kyc/kyc_view.dart';
import '../presentation/coach/trainee/live_chat/getx/live_chat_binding.dart';
import '../presentation/coach/trainee/live_chat/live_chat_view.dart';
import '../presentation/coach/trainee/progress/getx/progress_binding.dart';
import '../presentation/coach/trainee/progress/progress_view.dart';
import '../presentation/coach/trainee/trainee_view.dart';
import '../presentation/coach/trainee/user_history/getx/history_binding.dart';
import '../presentation/coach/trainee/user_history/history_view.dart';
import '../presentation/coach/video_chat/getx/video_chat_binding.dart';
import '../presentation/coach/video_chat/video_chat_view.dart';
import '../presentation/coach/workouts/getx/workout_binding.dart';
import '../presentation/coach/workouts/workouts_view.dart';
import '../presentation/splash/getx/splash_binding.dart';
import '../presentation/splash/splash_view.dart';
import '../presentation/trainee/coach/Personalized/calender/calender_view.dart';
import '../presentation/trainee/coach/Personalized/calender/getx/calender_binding.dart';
import '../presentation/trainee/coach/Personalized/getx/personalized_binding.dart';
import '../presentation/trainee/coach/Personalized/personal_training/getx/personal_training_binding.dart';
import '../presentation/trainee/coach/Personalized/personal_training/personal_training_view.dart';
import '../presentation/trainee/coach/Personalized/personalized_view.dart';
import '../presentation/trainee/coach/Personalized/video_chat/getx/video_chat_binding.dart';
import '../presentation/trainee/coach/Personalized/video_chat/video_chat_view.dart';
import '../presentation/trainee/coach/challenge/challenge_view.dart';
import '../presentation/trainee/coach/challenge/getx/challenge_binding.dart';
import '../presentation/trainee/coach/coach_view.dart';
import '../presentation/trainee/coach/exercises/exercises_view.dart';
import '../presentation/trainee/coach/exercises/getx/exercises_binding.dart';
import '../presentation/trainee/coach/favorites/favorites_view.dart';
import '../presentation/trainee/coach/favorites/getx/favorites_binding.dart';
import '../presentation/trainee/coach/getx/coach_binding.dart';
import '../presentation/trainee/coach/history/getx/history_binding.dart';
import '../presentation/trainee/coach/history/history_view.dart';
import '../presentation/trainee/coach/kyc/getx/kyc_binding.dart';
import '../presentation/trainee/coach/kyc/kyc_view.dart';
import '../presentation/trainee/coach/live_chat/getx/live_chat_binding.dart';
import '../presentation/trainee/coach/live_chat/live_chat_view.dart';
import '../presentation/trainee/coach/shop/getx/shop_binding.dart';
import '../presentation/trainee/coach/shop/shop_view.dart';
import '../presentation/trainee/coach/today_work_out/getx/today_work_out_binding.dart';
import '../presentation/trainee/coach/today_work_out/today_work_out_view.dart';
import '../presentation/trainee/coach/workouts/getx/workout_binding.dart';
import '../presentation/trainee/coach/workouts/workouts_view.dart';
import '../presentation/trainee/home/contact_us/contact_us_view.dart';
import '../presentation/trainee/home/contact_us/getx/contact_us_binding.dart';
import '../presentation/trainee/home/follow_us/follow_us_view.dart';
import '../presentation/trainee/home/follow_us/getx/follow_us_binding.dart';
import '../presentation/trainee/home/getx/home_binding.dart';
import '../presentation/trainee/home/home_view.dart';
import '../presentation/trainee/home/news/getx/news_binding.dart';
import '../presentation/trainee/home/news/news_view.dart';
import '../presentation/trainee/home/nutrition/calorie_calculator/calorie_calculator_view.dart';
import '../presentation/trainee/home/nutrition/calorie_calculator/getx/calorie_calculator_binding.dart';
import '../presentation/trainee/home/nutrition/food/food_view.dart';
import '../presentation/trainee/home/nutrition/food/getx/food_binding.dart';
import '../presentation/trainee/home/nutrition/getx/nutrition_binding.dart';
import '../presentation/trainee/home/nutrition/nutrition_view.dart';
import '../presentation/trainee/home/nutrition/recipes/getx/recipes_binding.dart';
import '../presentation/trainee/home/nutrition/recipes/recipes_view.dart';
import '../presentation/trainee/home/nutrition/supplement/getx/supplement_binding.dart';
import '../presentation/trainee/home/nutrition/supplement/supplement_view.dart';
import '../presentation/trainee/home/progress/getx/progress_binding.dart';
import '../presentation/trainee/home/progress/progress_view.dart';
import '../presentation/trainee/home/questionnaire/getx/questionnaire_binding.dart';
import '../presentation/trainee/home/trainer/getx/trainer_binding.dart';
import '../presentation/trainee/home/trainer/trainer_view.dart';
import '../presentation/trainee/profile/assigned_coach/assigned_coach_view.dart';
import '../presentation/trainee/profile/assigned_coach/getx/assigned_coach_binding.dart';
import '../presentation/trainee/profile/getx/profile_binding.dart';
import '../presentation/trainee/profile/profile_view.dart';
import '../presentation/trainee/profile/setting/getx/setting_binding.dart';
import '../presentation/trainee/profile/setting/setting_view.dart';

class Routes {
  //////////// Auth ///////////////
  static const String splashRoute = "/";
  static const String aboutYouRoute = "/aboutYouRoute";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String verifiedEmailRoute = "/verifiedEmail";
  static const String resetPasswordRoute = "/resetPassword";
  static const String otpRoute = "/otpRoute";

  static const String coachHomeRoute = "/coachHomeRoute";

  static const String homeRoute = "/homeRoute";
  static const String coachRoute = "/coachRoute";
  static const String profileRoute = "/profileRoute";

  //////////// Home trainee ///////////////
  static const String followUsRoute = "/followUsRoute";
  static const String contactUsRoute = "/contactUsRoute";
  static const String newsRoute = "/newsRoute";
  static const String trainersRoute = "/trainersRoute";
  static const String progressRoute = "/progressRoute";
  static const String nutritionRoute = "/nutritionRoute";
  static const String faqsRoute = "/faqsRoute";
  static const String questionnaireRoute = "/questionnaireRoute";
  static const String foodRoute = "/foodRoute";
  static const String supplementRoute = "/supplementRoute";
  static const String calorieCalculatorRoute = "/calorieCalculatorRoute";
  static const String recipeRoute = "/recipeRoute";

  //////////// coach trainee ///////////////
  static const String exercisesRoute = "/exercisesRoute";
  static const String workoutRoute = "/workoutRoute";
  static const String kycRoute = "/kycRoute";
  static const String personalTrainingRoute = "/personalTrainingRoute";
  static const String challengesRoute = "/challengesRoute";
  static const String personalizedRoutes = "/personalizedRoutes";
  static const String historyRoute = "/historyRoute";
  static const String favoriteRoute = "/favoriteRoute";
  static const String calenderRoute = "/calenderRoute";
  static const String todayWorkOutRoute = "/todayWorkOutRoute";
  static const String shopRoute = "/shopRoute";
  static const String shopDetailsRoute = "/shopRoute";

  static const String videoChatRoute = "/videoChatRoute";
  static const String liveChatRoute = "/liveChatRoute";

  //////////// profile trainee ///////////////
  static const String assignedCoachesRoute = "/assignedCoachesRoute";
  static const String settingRoute = "/settingRoute";

  //////////// Home coach ///////////////
  static const String exercisesCoachRoute = "/exercisesCoachRoute";
  static const String workoutCoachRoute = "/workoutCoachRoute";
  static const String challengesCoachRoute = "/challengesCoachRoute";
  static const String personalTrainingCoachRoute =
      "/personalTrainingCoachRoute";
  static const String calenderCoachRoute = "/calenderCoachRoute";
  static const String videoChatCoachRoute = "/videoChatCoachRoute";
  static const String traineeCoachRoute = "/traineeRouteCoachRoute";
  static const String liveChatCoachRoute = "/liveChatCoachRoute";
  static const String kycCoachRoute = "/kycCoachRoute";
  static const String userHistoryCoachRoute = "/userHistoryCoachRoute";
  static const String progressCoachRoute = "/progressCoachRoute";
}

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.splashRoute;

  static final List<GetPage> pages = [
    GetPage(
        name: Routes.splashRoute,
        page: () => const SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.aboutYouRoute,
        page: () => const AboutYouView(),
        binding: AboutYouBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.loginRoute,
        page: () => const LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.registerRoute,
        page: () => const RegisterView(),
        binding: RegisterBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.forgetPasswordRoute,
        page: () => const ForgetPasswordView(),
        binding: ForgetPasswordBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.verifiedEmailRoute,
        page: () => const VerifiedEmailView(),
        binding: VerifiedEmailBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.resetPasswordRoute,
        page: () => const ResetPasswordView(),
        binding: ResetPasswordBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.otpRoute,
        page: () => const OtpView(),
        binding: OtpBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.coachHomeRoute,
        page: () => const CoachHomeView(),
        binding: CoachHomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.homeRoute,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.coachRoute,
        page: () => const CoachView(),
        binding: CoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

    GetPage(
        name: Routes.profileRoute,
        page: () => const ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.followUsRoute,
        page: () => const FollowUsView(),
        binding: FollowUsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.contactUsRoute,
        page: () => const ContactUsView(),
        binding: ContactUsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.newsRoute,
        page: () => const NewsView(),
        binding: NewsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.trainersRoute,
        page: () => const TrainerView(),
        binding: TrainerBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.progressRoute,
        page: () => const ProgressView(),
        binding: ProgressBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.nutritionRoute,
        page: () => const NutritionView(),
        binding: NutritionBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.faqsRoute,
        page: () => const FAQsView(),
        binding: FAQsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.questionnaireRoute,
        page: () => const SurveyView(),
        binding: QuestionnaireBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.foodRoute,
        page: () => const FoodView(),
        binding: FoodBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.supplementRoute,
        page: () => const SupplementView(),
        binding: SupplementBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.calorieCalculatorRoute,
        page: () => const CalorieCalculatorView(),
        binding: CalorieCalculatorBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.recipeRoute,
        page: () => const RecipesView(),
        binding: RecipesBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

    /////////////// trainee
    GetPage(
        name: Routes.exercisesRoute,
        page: () => const ExercisesView(),
        binding: ExercisesBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.workoutRoute,
        page: () => const WorkoutView(),
        binding: WorkoutsBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.kycRoute,
        page: () => const KycView(),
        binding: KycBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.personalTrainingRoute,
        page: () => const PersonalTrainingView(),
        binding: PersonalTrainingBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.challengesRoute,
        page: () => const ChallengeView(),
        binding: ChallengeBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.personalizedRoutes,
        page: () => const PersonalizedView(),
        binding: PersonalizedBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.historyRoute,
        page: () => const HistoryView(),
        binding: HistoryBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.favoriteRoute,
        page: () => const FavoritesView(),
        binding: FavoritesBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.calenderRoute,
        page: () => CalenderView(),
        binding: CalenderBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.todayWorkOutRoute,
        page: () => const TodayWorkOutView(),
        binding: TodayWorkOutBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.shopRoute,
        page: () => const ShopView(),
        binding: ShopBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.videoChatRoute,
        page: () => const VideoChatView(),
        binding: VideoChatBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.liveChatRoute,
        page: () => const LiveChatView(),
        binding: LiveChatBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.assignedCoachesRoute,
        page: () => const AssignedCoachView(),
        binding: AssignedCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.settingRoute,
        page: () => const SettingView(),
        binding: SettingBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

    ///// coach
    GetPage(
        name: Routes.exercisesCoachRoute,
        page: () => const ExercisesCoachView(),
        binding: ExercisesCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.workoutCoachRoute,
        page: () => const WorkoutCoachView(),
        binding: WorkoutCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.challengesCoachRoute,
        page: () => const ChallengeCoachView(),
        binding: ChallengeCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.personalTrainingCoachRoute,
        page: () => const PersonalTrainingCoachView(),
        binding: PersonalTrainingCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.calenderCoachRoute,
        page: () => const CalenderCoachView(),
        binding: CalenderCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),

    GetPage(
        name: Routes.videoChatCoachRoute,
        page: () => const VideoChatCoachView(),
        binding: VideoChatCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.traineeCoachRoute,
        page: () => const TraineeCoachView(),
        binding: TraineeCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.liveChatCoachRoute,
        page: () => const LiveChatCoachView(),
        binding: LiveChatCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.kycCoachRoute,
        page: () => const KycCoachView(),
        binding: KycCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.userHistoryCoachRoute,
        page: () => const UserHistoryCoachView(),
        binding: UserHistoryCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: Routes.progressCoachRoute,
        page: () => const ProgressCoachView(),
        binding: ProgressCoachBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}
