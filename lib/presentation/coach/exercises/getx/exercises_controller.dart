import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../../../domain/entities/coach_entities/video_entity.dart';
import '../../../widgets/toasts_messages.dart';
import '../../getx/coach_home_controller.dart';

class ExercisesCoachController extends GetxController {
  RxInt sectionSelect = 0.obs;
  TextEditingController search = TextEditingController();

  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool isFavourite = false.obs;
  final RxBool isWorkout = false.obs;
  final RxBool isTodayLog = false.obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

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
    (await baseCoachAppRepository
            .getSectionExercise(Get.find<CoachHomeController>().coachId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<SectionExercisesEntity> data) => {
                  if (data.isNotEmpty)
                    {
                      sections = data,
                      deleteEmptyCategories(),
                      deleteEmptySection(),
                      if (data[sectionSelect.value].category.isNotEmpty)
                        exercise.value =
                            data[sectionSelect.value].category[0].exercises
                    }
                });
    isLoading = false;
  }

  getExercise() async {
    isLoading = true;
    (await baseCoachAppRepository.getExercise(
            Get.find<CoachHomeController>().coachId.value, search.text))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ExercisesEntity> data) => {exercise.value = data});
    isLoading = false;
  }

  List<VideoEntity> videos = [];
  List<TextEditingController> textLogController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  RxInt videoIndex = 0.obs;
  final RxString videoUrl = "".obs;

  getExerciseVideo(exerciseId) async {
    isLoading = true;
    (await baseCoachAppRepository.getExerciseVideo(
            Get.find<CoachHomeController>().coachId.value, exerciseId))
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

  @override
  void onInit() async {
    await getSectionExercise();
    super.onInit();
  }
}
