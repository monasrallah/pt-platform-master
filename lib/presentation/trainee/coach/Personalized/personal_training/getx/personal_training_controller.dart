import 'package:get/get.dart';
import 'package:pt_platform/app/app_controller.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/challenge_entity.dart';
import 'package:pt_platform/domain/entities/coach_entities/personalized_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/recipe_entity.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../../domain/entities/coach_entities/video_entity.dart';
import '../../../../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../../../../widgets/toasts_messages.dart';
import '../../../getx/coach_controller.dart';

class PersonalTrainingController extends GetxController {
  RxBool selectHome = true.obs;

  onTapHomeSection() {
    if (!selectHome.value) {
      selectHome.value = !selectHome.value;
    }
  }

  onTapPersonalisedSection() {
    if (selectHome.value) {
      selectHome.value = !selectHome.value;
    }
  }

  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isButtonLoading = false.obs;

  set isButtonLoading(bool val) => _isButtonLoading.value = val;

  bool get isButtonLoading => _isButtonLoading.value;

  List<ChallengeEntity> workouts = [];

  getAssignedWorkout() async {
    isLoading = true;
    (await baseCoachRepository
            .getAssignedWorkout(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ChallengeEntity> data) => {workouts = data});
    isLoading = false;
  }

  List<RecipeEntity> meals = [];

  getAssignedMeals() async {
    isLoading = true;
    (await baseCoachRepository
            .getAssignedMeals(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<RecipeEntity> data) => {meals = data});
    isLoading = false;
  }

  PersonalizedEntity personalized =
      PersonalizedEntity(video: [], image: [], pdf: [], freeText: []);

  getPersonalized() async {
    isLoading = true;
    (await baseCoachRepository
            .getPersonalized(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (PersonalizedEntity data) => {personalized = data});
    isLoading = false;
  }

  final RxBool isFavourite = false.obs;
  final RxBool isWorkout = false.obs;
  final RxBool isTodayLog = false.obs;

  List<VideoEntity> videos = [];

  RxInt numberOfSet = 1.obs;

  RxInt videoIndex = 0.obs;
  final RxString videoUrl = "".obs;

  getPersonalTrainingVideo(int workoutId) async {
    isLoading = true;
    (await baseCoachRepository.getPersonalTrainingVideo(
            Get.find<CoachController>().coachId.value, workoutId))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {
                  videos = data,
                  isFavourite.value = videos[videoIndex.value].isFavourite,
                  isWorkout.value = videos[videoIndex.value].isWorkout,
                  isTodayLog.value = videos[videoIndex.value].isTodayLog,
                  videoUrl.value = videos[videoIndex.value].video,
                });
    isLoading = false;
  }

  onSwitchAnotherVideo(int index) {
    videoIndex.value = index;
    isFavourite.value = videos[videoIndex.value].isFavourite;
    isWorkout.value = videos[videoIndex.value].isWorkout;
    isTodayLog.value = videos[videoIndex.value].isTodayLog;
    videoUrl.value = videos[videoIndex.value].video;
  }

  addFavouriteVideo(int videoId) async {
    isButtonLoading = true;
    (await baseCoachRepository.addFavouriteVideo(VideoCoachIdParams(
            date:
                "${DateTime.now().year}-${DateTime.now().month}-${(DateTime.now().day)}",
            videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isFavourite.value = !isFavourite.value});
    isButtonLoading = false;
  }

  addTodayWorkOutVideo(int videoId) async {
    isButtonLoading = true;
    (await baseCoachRepository.addTodayWorkOutVideo(VideoCoachIdParams(
            date:
                "${DateTime.now().year}-${DateTime.now().month}-${(DateTime.now().day)}",
            videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isWorkout.value = !isWorkout.value});
    isButtonLoading = false;
  }

  openLogDialog() async {
    isButtonLoading = true;
    await Get.find<AppController>()
        .openLogDialog(videoId: videos[videoIndex.value].id);
    isButtonLoading = false;
  }

  @override
  void onInit() async {
    await getAssignedWorkout();
    await getAssignedMeals();
    await getPersonalized();
    super.onInit();
  }
}
