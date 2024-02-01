import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/coach_app/coach_app_repo/coach_app_repository.dart';
import 'package:pt_platform/domain/core/entities/failure.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../app/storage/app_prefs.dart';
import '../../../../../domain/entities/coach_entities/exercise_logs_entity.dart';
import '../../../../../domain/entities/coach_entities/video_entity.dart';
import '../../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../../resources/functions/date_format_function.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/trainee_controller.dart';

class UserHistoryCoachController extends GetxController {
  RxBool visible = false.obs;
  RxInt selected = 0.obs;

  RxString date = dateFormat(date: DateTime.now()).obs;
  DateTime selectedDate = DateTime.now();

  Rx<Failure> failure = Failure.Default().obs;

  List<String> foodsList = [
    "DATE",
    "NECK",
    "CHEST",
    "LEFT ARM",
    "RIGHT ARM",
    "WAIST",
    "BELLY",
    "LOWER BELLY",
    "UPPER BELLY",
    "HIPS",
    "LEFT THIGH",
    "RIGHT THIGH",
    "LEFT CALF",
    "RIGHT CALF",
  ];

  Color color = Colors.transparent;

  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingLogs = false.obs;

  set isLoadingLogs(bool val) => _isLoadingLogs.value = val;

  bool get isLoadingLogs => _isLoadingLogs.value;

  Rx<FoodEntity> foodEntity = FoodEntity.init().obs;

  List<VideoEntity> videos = [];

  getExerciseHistory() async {
    isLoading = true;
    (await baseCoachAppRepository.getExerciseHistory(
            Get.find<TraineeCoachController>().traineeId.value, coachId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message!.orEmpty()),
            (List<VideoEntity> data) => {videos = data});
    isLoading = false;
  }

  List<ExerciseLogsEntity> logs = [];

  getExerciseLogs(int exerciseLogId ) async {
    print("exerciseLogId $exerciseLogId");
    isLoadingLogs = true;
    (await baseCoachAppRepository.getExerciseLogs(exerciseLogId ,Get.find<TraineeCoachController>().traineeId.value ,coachId.value)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<ExerciseLogsEntity> data) => {logs = data});
    isLoadingLogs = false;
  }

  getFoodHistory() async {
    isLoading = true;
    (await baseCoachAppRepository.getFoodHistory(
            date.value, Get.find<TraineeCoachController>().traineeId.value))
        .fold((failure) {
      this.failure.value = failure;
      return showFlutterToast(message: failure.message.orEmpty());
    }, (FoodEntity data) => {foodEntity.value = data});
    isLoading = false;
  }

  RxString coachId = "".obs;

  @override
  void onInit() async {
    coachId.value = instance<AppPreferences>().getCoachEntity().isNotEmpty
        ? instance<AppPreferences>().getCoachEntity()[0]
        : "";
    super.onInit();
  }
}
