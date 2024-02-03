import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/debug/log.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/coach/coach_repo/coach_repository.dart';
import 'package:pt_platform/domain/core/entities/failure.dart';
import 'package:pt_platform/domain/entities/coach_entities/personalized_entity.dart';
import 'package:pt_platform/resources/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_controller.dart';
import '../../../../app/dependency_injection.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../data/home/home_repo/home_repository.dart';
import '../../../../data/profile/profile_repo/profile_repository.dart';
import '../../../../domain/entities/auth_entities/coach_entity.dart';
import '../../../../domain/entities/home_entities/banner_entity.dart';
import '../../../../domain/parameters/coach_params/packege_payment_params.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';
import '../shop/widget/web_view_page.dart';

class CoachController extends GetxController {
  final CarouselController carouselController = CarouselController();
  RxInt indexSpecialStore = 1.obs;
  Rx<Failure> failure = Failure.Default().obs;

  RxList<Widget> imageSliders = <Widget>[].obs;

  List<String> gridImageList = [
    ImageCoachAssets.excersize,
    ImageCoachAssets.workoutPlan,
    ImageCoachAssets.KYC,
    ImageCoachAssets.CHALLENGES,
    ImageCoachAssets.PERSONALTRAINING,
    ImageCoachAssets.HISTORY,
    ImageCoachAssets.FAVOURITES,
    ImageCoachAssets.TODAYSWORKOUT,
    ImageCoachAssets.SHOP,
    ImageCoachAssets.LIVECHAT,
  ];

  List<String> gridTileList = [
    AppStrings.exercises.tr,
    AppStrings.workouts.tr,
    AppStrings.kyc.tr,
    AppStrings.challenges.tr,
    AppStrings.personalised.tr,
    AppStrings.history.tr,
    AppStrings.favorites.tr,
    AppStrings.todayWorkout.tr,
    AppStrings.shop.tr,
    AppStrings.liveChat.tr,
  ];

  List<Function> gridOnTapList = [
    () {
      Get.toNamed(Routes.exercisesRoute);
    },
    () {
      Get.toNamed(Routes.workoutRoute);
    },
    () {
      Get.toNamed(Routes.kycRoute);
    },
    () {
      Get.toNamed(Routes.challengesRoute);
    },
    () {
      Get.toNamed(Routes.personalizedRoutes);
    },
    () {
      Get.toNamed(Routes.historyRoute);
    },
    () {
      Get.toNamed(Routes.favoriteRoute);
    },
    () {
      Get.toNamed(Routes.todayWorkOutRoute);
    },
    () {
      Get.toNamed(Routes.shopRoute);
    },
    () {
      Get.toNamed(Routes.liveChatRoute);
    },
  ];

  BaseProfileRepository baseProfileRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  Rx<CoachEntity> coachEntity = CoachEntity().obs;
  RxInt coachIndex = 0.obs;

  List<CoachEntity> coaches = [];

  getAssignedCoaches() async {
    isLoading = true;
    (await baseProfileRepository.getAssignedCoaches()).fold(
        (failure) => {
              this.failure.value = failure,
              showFlutterToast(message: failure.message.orEmpty())
            },
        (List<CoachEntity> data) => {
              coaches = data,
              if (data.isNotEmpty)
                {
                  coachEntity.value = coaches[0],
                  coachName.value.isEmpty
                      ? coachName.value = coaches[0].lastName.orEmpty()
                      : coachName.value,
                  // coachId.value.isEmpty ?
                  coachId.value = coaches[0].id.toString(),
                  // : coachId.value,
                  coachAvatar.value.isEmpty
                      ? coachAvatar.value = coaches[0].logo.toString()
                      : coachAvatar.value,
                  instance<AppPreferences>().setCoachEntity([
                    coachId.value,
                    coachName.value,
                    coachAvatar.value,
                  ]),
                }
              else if (coachName.value.isNotEmpty)
                {
                  instance<AppPreferences>().setCoachEntity([
                    coachId.value,
                    coachName.value,
                    coachAvatar.value,
                  ]),
                }
              else
                {
                  Get.toNamed(Routes.trainersRoute),
                }
            });
    isLoading = false;
  }

  BaseHomeRepository baseHomeRepository = instance();

  BaseCoachRepository baseCoachRepository = instance();

  RxList<BannerEntity> banners = <BannerEntity>[].obs;

  getBanner() async {
    isLoading = true;
    (await baseHomeRepository.getBanner(coachId.value)).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (List<BannerEntity> data) {
      banners.value = data;
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
          .toList();
      return {banners};
    });
    isLoading = false;
  }

  List<DataEntity> tips = [];

  getTips() async {
    isLoading = true;
    (await baseCoachRepository.getTips(coachId.value)).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (List<DataEntity> data) => {tips = data});
    isLoading = false;
  }

  checkout(int id, String paymentMethod) async {
    Get.back();
    isLoading = true;

    (await baseCoachRepository.checkoutTips(
      TipsPaymentParams(
        id: id,
        paymentMethod: paymentMethod,
        coachId: coachId.value,
      ),
    ))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) {
      if (paymentMethod == "stripe") {
        launchUrl(Uri.parse(data.url));
        // Route route =
        //     MaterialPageRoute(builder: (_) => WebViewApp(url: data.url));
        //
        // Navigator.push(Get.context!, route);
      } else {
        Get.find<AppController>().onItemTapped(1);
      }
    });

    isLoading = false;
  }

  //   checkout(int id, String paymentMethod) async {
  //   isLoading = true;
  //   (await baseCoachRepository.checkout(PackagePaymentParams(
  //           id: id,
  //           paymentMethod: paymentMethod,
  //           code: codeController.text,
  //           coachId: coachId.value)))
  //       .fold(
  //           (failure) => showFlutterToast(message: failure.message.orEmpty()),
  //           (StripeEntity data) => {
  //                 // Get.find<AppController>().onItemTapped(1),
  //                 showFlutterToast(message: "success"),
  //                 paymentMethod == "stripe"
  //                     ? Get.to(() => WebViewApp(url: data.url))
  //                     : Get.find<AppController>().onItemTapped(1),
  //               });
  //   isLoading = false;
  // }

  RxString userId = "".obs;
  RxString coachId = "".obs;
  RxString coachName = "".obs;
  RxString coachAvatar = "".obs;

  @override
  void onInit() async {
    userId.value = instance<AppPreferences>().getUserEntity().isNotEmpty
        ? instance<AppPreferences>().getUserEntity()[0]
        : "";
    coachId.value = instance<AppPreferences>().getCoachEntity().isNotEmpty
        ? instance<AppPreferences>().getCoachEntity()[0]
        : "";
    coachName.value = instance<AppPreferences>().getCoachEntity().length > 1
        ? instance<AppPreferences>().getCoachEntity()[1]
        : "";
    coachAvatar.value = instance<AppPreferences>().getCoachEntity().length > 2
        ? instance<AppPreferences>().getCoachEntity()[2]
        : "";

    // print(instance<AppPreferences>().getCoachEntity()[0]);
    // print(instance<AppPreferences>().getCoachEntity()[1]);
    // print(instance<AppPreferences>().getCoachEntity()[2]);

    await getAssignedCoaches();
    await getBanner();
    // ever(_isLoading,(_)=> print("loading"));
    // ever(banners,(_)=> print("banners"));
    // ever(imageSliders,(_)=> print("imageSliders"));

    super.onInit();
  }
}
