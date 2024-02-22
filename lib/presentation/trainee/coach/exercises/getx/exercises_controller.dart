import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/section_exercise_entity.dart';
import 'package:pt_platform/domain/entities/coach_entities/video_entity.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../../../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../../../widgets/dialogs/add_to_log_dialog.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/coach_controller.dart';
import '../../../../widgets/custom_video_player_widget.dart';

class ExercisesController extends GetxController {
  RxInt sectionSelect = 0.obs;
  TextEditingController search = TextEditingController();

  BaseCoachRepository baseCoachRepository = instance();

  final RxBool isFavourite = false.obs;
  final RxBool isWorkout = false.obs;
  final RxBool isTodayLog = false.obs;
  final RxString videoUrl = "".obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isButtonLoading = false.obs;

  set isButtonLoading(bool val) => _isButtonLoading.value = val;

  bool get isButtonLoading => _isButtonLoading.value;

  deleteEmptySection() {
    List<SectionExercisesEntity> sectionsToKeep = [];

    for (var i in sections) {
      if (i.category.isNotEmpty) {
        sectionsToKeep.add(i);
      }
    }

    // Update the original list with the filtered elements
    sections = sectionsToKeep;
  }

  deleteEmptyCategories() {
    List<SectionExercisesEntity> sectionsToKeep = [];

    for (int i = 0; i < sections.length; i++) {
      List<CategoryExercisesEntity> category = [];

      for (int j = 0; j < sections[i].category.length; j++) {
        if (sections[i].category[j].exercises.isNotEmpty) {
          category.add(CategoryExercisesEntity(
              id: sections[i].category[j].id,
              title: sections[i].category[j].title,
              exercises: sections[i].category[j].exercises));
        }
      }
      sectionsToKeep.add(SectionExercisesEntity(
          id: sections[i].id, title: sections[i].title, category: category));
    }

    // Update the original list with the filtered elements
    sections = sectionsToKeep;
  }

  List<SectionExercisesEntity> sections = [];
  RxList<ExercisesEntity> exercise = <ExercisesEntity>[].obs;

  getSectionExercise() async {
    isLoading = true;
    (await baseCoachRepository
            .getSectionExercise(Get.find<CoachController>().coachId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<SectionExercisesEntity> data) => {
                  sections = data,
                  deleteEmptyCategories(),
                  deleteEmptySection(),
                  if (data.isNotEmpty)
                    {
                      if (data[sectionSelect.value].category.isNotEmpty)
                        exercise.value =
                            data[sectionSelect.value].category[0].exercises
                    }
                });
    isLoading = false;
  }

  getExercise() async {
    isLoading = true;
    (await baseCoachRepository.getExercise(
            Get.find<CoachController>().coachId.value, search.text))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ExercisesEntity> data) => {exercise.value = data});
    isLoading = false;
  }

  List<VideoEntity> videos = [];

  RxInt videoIndex = 0.obs;

  getExerciseVideo(exerciseId) async {
    isLoading = true;
    (await baseCoachRepository.getExerciseVideo(
            Get.find<CoachController>().coachId.value, exerciseId))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<VideoEntity> data) => {
                  videos = data,
                  if (videos.isNotEmpty)
                    {
                      isFavourite.value = videos[videoIndex.value].isFavourite,
                      isWorkout.value = videos[videoIndex.value].isWorkout,
                      isTodayLog.value = videos[videoIndex.value].isTodayLog,
                      videoUrl.value = videos[videoIndex.value].video,
                    }
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
        date:"${DateTime.now().year}-${DateTime.now().month}-${(DateTime.now().day)}" ,

        videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isFavourite.value = !isFavourite.value});
    isButtonLoading = false;
  }

  addTodayWorkOutVideo(int videoId) async {
    isButtonLoading = true;
    (await baseCoachRepository.addTodayWorkOutVideo(VideoCoachIdParams(
        date:"${DateTime.now().year}-${DateTime.now().month}-${(DateTime.now().day)}" ,

        videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isWorkout.value = !isWorkout.value ,showFlutterToast(message: "success")});
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
    await getSectionExercise();
    super.onInit();
  }
}
