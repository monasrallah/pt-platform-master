import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/data/core/utils/api_routes/api_routes.dart';
import 'package:pt_platform/data/home/home_repo/home_repository.dart';
import 'package:pt_platform/domain/entities/home_entities/banner_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../widgets/toasts_messages.dart';

class HomeController extends GetxController {
  RxList<Widget> imageSliders = <Widget>[].obs;
  final CarouselController carouselController = CarouselController();
  RxInt indexSpecialStore = 1.obs;

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

  RxList<BannerEntity> banners = <BannerEntity>[].obs;

 

  @override
  void onInit() async {
    await getBanner();
    super.onInit();
  }

  getBanner() async {
    isLoading = true;
    (await baseHomeRepository.getBanner(null)).fold(
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

  ///---------------------///
  ///----Fetch Banners----///
  ///---------------------///
  // Future<Response> fetchBanners(BuildContext context) async {
  //   ///----Url
  //   String url = AppUrls.baseUrl + AppUrls.getBannerUrl;

  //   try {
  //     ///----Response (Get)
  //     await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Accept': 'application/json',
  //         "Authorization": "Bearer ${getUserToken(context)}",
  //       },
  //     );

  //     ///----Response Has Error
  //     if (response.hasError) {
  //       ApiErrors.logError(apiName: 'fetchAllBlogData', response: response);
  //       // errorDialog();
  //     }

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }
}
