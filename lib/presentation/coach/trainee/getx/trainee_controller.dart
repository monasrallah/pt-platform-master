import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_app_entity/user_entity.dart';

import '../../../../app/constants.dart';
import '../../../../app/dependency_injection.dart';
import '../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class TraineeCoachController extends GetxController {
  RxString traineeId = "50".obs;
  RxInt traineeIndex = 0.obs;
  RxInt sectionSelect = 0.obs;
  TextEditingController name = TextEditingController();

  List<String> sectionTitle = [
    "All",
    "PT Packages",
    "Premium Subscriptions",
    "Subscriptions",
  ];

  List<String> gridImageList = [
    IconsAssets.challenges,
    IconsAssets.person,
    IconsAssets.chat,
    IconsAssets.history,
    IconsAssets.progress,
  ];

  List<String> gridTileList = [
    'Challenges',
    "Kyc",
    "Live Chat",
    "User's History",
    "Progress",
  ];

  List<Function> gridOnTapList = [
    () {
      Get.toNamed(Routes.challengesCoachRoute);
    },
    () {
      Get.toNamed(Routes.kycCoachRoute);
    },
    () {
      Get.toNamed(Routes.liveChatCoachRoute);
    },
    () {
      Get.toNamed(Routes.userHistoryCoachRoute);
    },
    () {
      Get.toNamed(Routes.progressCoachRoute);
    },
  ];

  void onTapCard(index) {
    traineeIndex.value = index;
  }

  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  RxList<UserEntity> users = <UserEntity>[].obs;
  List<UserEntity> allUsers = [];

  getUsers() async {
    isLoading = true;
    (await baseCoachAppRepository.getUsers(search: name.text)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<UserEntity> data) => {
              users.value = data,
              allUsers = sortUser(data),
              getPremiumList(),
              getSubscriptionList(),
              getPTList()
            });
    isLoading = false;
  }

  List<UserEntity> sortUser(List<UserEntity> users) {
    // Sort the list of users based on the style key
    users.sort((a, b) => (Constants.styleOrder[a.style] ?? double.infinity)
        .compareTo(Constants.styleOrder[b.style] ?? double.infinity));
    return users;
  }

  List<UserEntity> premiumUsers = [];

  getPremiumList() {
    users.map((e) => e.type == "premium" ? premiumUsers.add(e) : null).toList();
    premiumUsers = sortUser(premiumUsers);
  }

  List<UserEntity> subscriptionUsers = [];

  getSubscriptionList() {
    users
        .map((e) => e.type == "subscription" ? subscriptionUsers.add(e) : null)
        .toList();
    subscriptionUsers = sortUser(subscriptionUsers);
  }

  List<UserEntity> pTUsers = [];

  getPTList() {
    users
        .map((e) => e.type == "personal_training" ? pTUsers.add(e) : null)
        .toList();
    pTUsers = sortUser(pTUsers);
  }

  onChangeSection() {
    if (sectionSelect.value == 0) {
      users.value = allUsers;
    } else if (sectionSelect.value == 1) {
      users.value = pTUsers;
    } else if (sectionSelect.value == 2) {
      users.value = premiumUsers;
    } else if (sectionSelect.value == 3) {
      users.value = subscriptionUsers;
    }
  }

  @override
  void onInit() async {
    await getUsers();
    super.onInit();
  }

  // getTrainee() {}
}
