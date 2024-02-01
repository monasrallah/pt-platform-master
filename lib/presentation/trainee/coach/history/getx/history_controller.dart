import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/exercise_logs_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../domain/entities/coach_entities/video_entity.dart';
import '../../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../../resources/functions/date_format_function.dart';
import '../../../../coach/trainee/getx/trainee_controller.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/coach_controller.dart';

class HistoryController extends GetxController {
  RxBool visible = false.obs;
  RxInt selected = 0.obs;

  RxString date = dateFormat(date: DateTime.now()).obs;
  DateTime selectedDate = DateTime.now();

  Color color = Colors.transparent;

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

  BaseCoachRepository baseCoachRepository = instance();

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
    (await baseCoachRepository
            .getExerciseHistory(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<VideoEntity> data) => {videos = data});
    isLoading = false;
  }

  List<ExerciseLogsEntity> logs = [];

  getExerciseLogs(int exerciseLogId) async {
    isLoadingLogs = true;
    (await baseCoachRepository.getExerciseLogs(
            exerciseLogId,
            Get.find<TraineeCoachController>().traineeId.value,
            Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ExerciseLogsEntity> data) => {logs = data});
    isLoadingLogs = false;
  }

  getFoodHistory() async {
    BaseHomeRepository baseHomeRepository = instance();
    isLoading = true;
    (await baseHomeRepository.getFoodHistory(date.value)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (FoodEntity data) => {foodEntity.value = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
