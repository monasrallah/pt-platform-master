import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/challenge_entity.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../../../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../../../../domain/parameters/coach_params/complete_challenge_video_params.dart';
import '../../../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../../../widgets/dialogs/add_to_log_dialog.dart';
import '../../../../widgets/toasts_messages.dart';

class ChallengeController extends GetxController {
  final RxInt _counterChallenge = 0.obs;

  int get counterChallenge => _counterChallenge.value;

  set counterChallenge(int value) {
    _counterChallenge.value = value;
  }

  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isButtonLoading = false.obs;

  set isButtonLoading(bool val) => _isButtonLoading.value = val;

  bool get isButtonLoading => _isButtonLoading.value;

  List<ChallengeEntity> challenges = [];

  Future<void> getChallenges() async {
    isLoading = true;
    (await baseCoachRepository
            .getChallenges(Get.find<CoachController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ChallengeEntity> data) => {challenges = data});
    isLoading = false;
  }

  completeChallenges() async {
    isLoading = true;
    newChallengeAcceptedId.isNotEmpty
        ? (await baseCoachRepository.completeChallengeVideo(
                CompleteChallengeVideoParams(
                    challenge_video_ids: newChallengeAcceptedId!,
                    coachId: Get.find<CoachController>().coachId.value)))
            .fold(
                (failure) =>
                    showFlutterToast(message: failure.message.orEmpty()),
                (data) => {
                      showFlutterToast(message: "success"),
                      getChallenges()
                          .then((value) => newChallengeAcceptedId?.clear()),
                    })
        : null;
    isLoading = false;
  }

  RxList<int> challengeAcceptedId = <int>[].obs;
  RxList<int> newChallengeAcceptedId = <int>[].obs;

  addAcceptedToList() {
    videos
        .map((e) => e.isComplete ? challengeAcceptedId.add(e.id) : null)
        .toList();
  }

  final RxBool isFavourite = false.obs;
  final RxBool isWorkout = false.obs;
  final RxBool isTodayLog = false.obs;

  RxInt numberOfSet = 1.obs;
  RxInt videoIndex = 0.obs;
  final RxString videoUrl = "".obs;
  List<ChallengeVideoEntity> videos = [];

  videoChallenges(String challengeId) async {
    isLoading = true;
    (await baseCoachRepository.challengeVideo(ChallengeVideoParams(
            coachId: Get.find<CoachController>().coachId.value,
            challengeId: challengeId)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ChallengeVideoEntity> data) => {
                  challengeAcceptedId.clear(),
                  videos = data,
                  addAcceptedToList()
                });
    isLoading = false;
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
    newChallengeAcceptedId?.clear();
    await getChallenges();
    super.onInit();
  }
}
