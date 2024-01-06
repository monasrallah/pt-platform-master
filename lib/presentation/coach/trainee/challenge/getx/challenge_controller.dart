import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/trainee_controller.dart';

class ChallengeCoachController extends GetxController {
  final RxInt _counterChallenge = 0.obs;

  int get counterChallenge => _counterChallenge.value;

  set counterChallenge(int value) {
    _counterChallenge.value = value;
  }

  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<ChallengeEntity> challenges = [];

  getChallenges() async {
    isLoading = true;
    (await baseCoachAppRepository
            .getChallenges(Get.find<TraineeCoachController>().traineeId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ChallengeEntity> data) => {challenges = data});
    isLoading = false;
  }

  RxInt videoIndex = 0.obs;
  final RxString videoUrl = "".obs;
  List<ChallengeVideoEntity> videos = [];
  RxList<int> challengeAcceptedId = <int>[].obs;

  addAcceptedToList() {
    videos
        .map((e) => e.isComplete ? challengeAcceptedId.add(e.id) : null)
        .toList();
  }

  videoChallenges(String challengeId) async {
    isLoading = true;
    (await baseCoachAppRepository.challengeVideo(ChallengeVideoParams(
            coachId: Get.find<TraineeCoachController>().traineeId.value,
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

  @override
  void onInit() async {
    await getChallenges();
    super.onInit();
  }
}
