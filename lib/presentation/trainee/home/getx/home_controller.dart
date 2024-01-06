import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/home/home_repo/home_repository.dart';
import 'package:pt_platform/domain/entities/home_entities/banner_entity.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class HomeController extends GetxController {
  List<String> gridImageList1 = [
    IconsAssets.icon_nutrition,
    IconsAssets.icon_progress,
    IconsAssets.icon_coaches,
  ];

  List<String> gridImageList2 = [
    IconsAssets.icon_follow_us,
    IconsAssets.icon_contact_us,
    IconsAssets.icon_news,
    IconsAssets.icon_faqs,
    IconsAssets.icon_questionnaire,
  ];

  List<String> gridTileList1 = [
    "Nutrition",
    "Progress",
    "Coaches",
  ];

  List<String> gridTileList2 = [
    "FollowUs",
    "Contact Us",
    'News',
    "FAQs",
    "Questionnaire",
  ];

  List<Function> gridOnTapList1 = [
    () {
      Get.toNamed(Routes.nutritionRoute);
    },
    () {
      Get.toNamed(Routes.progressRoute);
    },
    () {
      Get.toNamed(Routes.trainersRoute);
    },
  ];

  List<Function> gridOnTapList2 = [
    () {
      Get.toNamed(Routes.followUsRoute);
    },
    () {
      Get.toNamed(Routes.contactUsRoute);
    },
    () {
      Get.toNamed(Routes.newsRoute);
    },
    () {
      Get.toNamed(Routes.faqsRoute);
    },
    () {
      Get.toNamed(Routes.questionnaireRoute);
    },
  ];

  BaseHomeRepository baseHomeRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<BannerEntity> banners = [];

  getBanner() async {
    isLoading = true;
    (await baseHomeRepository.getBanner(null)).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (List<BannerEntity> data) => {banners = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getBanner();
    super.onInit();
  }
}
