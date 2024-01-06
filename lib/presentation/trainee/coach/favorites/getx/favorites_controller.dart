import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/video_entity.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../../../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../../../widgets/dialogs/add_to_log_dialog.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/coach_controller.dart';

class FavoritesController extends GetxController {
  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isButtonLoading = false.obs;

  set isButtonLoading(bool val) => _isButtonLoading.value = val;

  bool get isButtonLoading => _isButtonLoading.value;

  List<VideoEntity> favorites = [];

  getFavorite() async {
    isLoading = true;
    (await baseCoachRepository
            .getFavorite(Get.find<CoachController>().coachId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<VideoEntity> data) => {
                  favorites = data,
                  if (data.isNotEmpty)
                    {
                      isFavourite.value =
                          favorites[videoIndex.value].isFavourite,
                      isWorkout.value = favorites[videoIndex.value].isWorkout,
                      isTodayLog.value = favorites[videoIndex.value].isTodayLog
                    }
                });
    isLoading = false;
  }

  final RxBool isFavourite = false.obs;
  final RxBool isWorkout = false.obs;
  final RxBool isTodayLog = false.obs;

  RxInt numberOfSet = 1.obs;

  RxInt videoIndex = 0.obs;
  final RxString videoUrl = "".obs;

  onSwitchAnotherVideo(int index) {
    videoIndex.value = index;
    isFavourite.value = favorites[videoIndex.value].isFavourite;
    isWorkout.value = favorites[videoIndex.value].isWorkout;
    isTodayLog.value = favorites[videoIndex.value].isTodayLog;
    videoUrl.value = favorites[videoIndex.value].video;
  }

  addFavouriteVideo(int videoId) async {
    isButtonLoading = true;
    (await baseCoachRepository.addFavouriteVideo(VideoCoachIdParams(
            videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isFavourite.value = !isFavourite.value});
    isButtonLoading = false;
  }

  addTodayWorkOutVideo(int videoId) async {
    isButtonLoading = true;
    (await baseCoachRepository.addTodayWorkOutVideo(VideoCoachIdParams(
            videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {isWorkout.value = !isWorkout.value});
    isButtonLoading = false;
  }

  openLogDialog() async {
    isButtonLoading = true;
    await Get.find<AppController>()
        .openLogDialog(videoId: favorites[videoIndex.value].id);
    isButtonLoading = false;
  }

  @override
  void onInit() async {
    await getFavorite();
    super.onInit();
  }
}
