import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/coach_app/coach_app_repo/coach_app_repository.dart';
import 'package:pt_platform/presentation/widgets/dialogs/language/language_controller.dart';
import 'package:pt_platform/presentation/widgets/dialogs/language/language_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../app/dependency_injection.dart';
import '../../../app/storage/app_prefs.dart';
import '../../../data/auth/auth_repo/auth_repository.dart';
import '../../../data/profile/profile_repo/profile_repository.dart';
import '../../../domain/entities/home_entities/banner_entity.dart';
import '../../../domain/parameters/profile/delete_account_params.dart';
import '../../../resources/strings_manager.dart';
import '../../widgets/toasts_messages.dart';

class CoachHomeController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  final CarouselController carouselController = CarouselController();
  RxInt indexSpecialStore = 1.obs;
  RxList<Widget> imageSliders = <Widget>[].obs;

  List<String> gridImageList = [
    IconsAssets.dumbbells,
    IconsAssets.workouts,
    // IconsAssets.challenges,
    // IconsAssets.personalTraining,
    IconsAssets.calendar,
    IconsAssets.video,
    // IconsAssets.chat,
    IconsAssets.person,
    // IconsAssets.history,
    // IconsAssets.progress,
    IconsAssets.person,
    IconsAssets.history,
    IconsAssets.progress,
  ];

  List<String> gridTileList = [
    AppStrings.exercises.tr,
    AppStrings.workouts.tr,
    // 'Challenges',
    // "Personal Training",
    AppStrings.calendar.tr,
    AppStrings.videoChat.tr,
    // "Live Chat",
    AppStrings.trainee.tr,
    // "User's History",
    // "Progress",
    AppStrings.language.tr,
    AppStrings.deleteMyAccount.tr,
    AppStrings.logout.tr,
  ];

  List<Function> gridOnTapList = [
    () {
      Get.toNamed(Routes.exercisesCoachRoute);
    },
    () {
      Get.toNamed(Routes.workoutCoachRoute);
    },
    // () {
    //   Get.toNamed(Routes.challengesCoachRoute);
    // },
    // () {
    //   Get.toNamed(Routes.personalTrainingCoachRoute);
    // },
    () {
      Get.toNamed(Routes.calenderCoachRoute);
    },
    () {
      Get.toNamed(Routes.videoChatCoachRoute);
    },
    // () {
    //   Get.toNamed(Routes.liveChatCoachRoute);
    // },
    () {
      Get.toNamed(Routes.traineeCoachRoute);
    },
    // () {
    //   Get.toNamed(Routes.userHistoryCoachRoute);
    // },
    // () {
    //   Get.toNamed(Routes.progressCoachRoute);
    // },
    () {
      Get.lazyPut(() => LanguageController());
      Get.dialog(LanguageDialog(toDo: () {}));
    },
    () {},
    () {
      Get.offAllNamed(Routes.aboutYouRoute);
    },
  ];

  deleteAccount() async {
    BaseProfileRepository baseProfileRepository = instance();
    isLoading = true;
    (await baseProfileRepository.deleteAccount(DeleteAccountParams(
            password: passwordController.text, devicePlayerId: "player_id")))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {Get.offNamed(Routes.aboutYouRoute)});
    isLoading = false;
    passwordController.clear();
  }

  logout() async {
    final BaseAuthRepository authRepository = instance();

    isLogoutLoading = true;
    (await authRepository.logout("player_id")).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) => Get.offAllNamed(Routes.aboutYouRoute));
    isLogoutLoading = false;
  }

  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isLogoutLoading = false.obs;

  set isLogoutLoading(bool val) => _isLogoutLoading.value = val;

  bool get isLogoutLoading => _isLogoutLoading.value;

  RxList<BannerEntity> banners = <BannerEntity>[].obs;

  getBanner() async {
    isLoading = true;
    (await baseCoachAppRepository.getBanner(int.tryParse(coachId.value))).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) => {
              banners.value = data,
              imageSliders.value = banners
                  .map((item) => InkWell(
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                        onTap: () async {
                          item.url.isNotEmpty
                              ? await launchUrl(Uri.parse(item.url))
                              : {};
                        },
                      ))
                  .toList(),
            });
    isLoading = false;
  }

  RxString coachId = "".obs;

  @override
  void onInit() async {
    coachId.value = instance<AppPreferences>().getCoachEntity().isNotEmpty
        ? instance<AppPreferences>().getCoachEntity()[0]
        : "";

    await getBanner();
    super.onInit();
  }
}
