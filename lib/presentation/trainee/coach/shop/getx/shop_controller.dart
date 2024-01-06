import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/app/storage/app_prefs.dart';
import 'package:pt_platform/domain/entities/coach_entities/personalized_entity.dart';
import 'package:pt_platform/domain/entities/coach_entities/shop_entity.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/coach_params/check_promo_code_params.dart';
import '../../../../../domain/parameters/coach_params/packege_payment_params.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/coach_controller.dart';
import '../widget/web_view_page.dart';

class ShopController extends GetxController {
  TextEditingController codeController = TextEditingController();
  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  ShopEntity shop =
      ShopEntity(subscription: [], personalTraining: [], premium: []);

  getShop() async {
    isLoading = true;
    (await baseCoachRepository.getShop(coachId.value)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (ShopEntity data) => {shop = data});
    isLoading = false;
  }

  List<DataEntity> tips = [];

  getTips() async {
    isLoading = true;
    (await baseCoachRepository.getTips(coachId.value)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<DataEntity> data) => {tips = data});
    isLoading = false;
  }

  checkout(int id, String paymentMethod) async {
    isLoading = true;
    (await baseCoachRepository.checkout(PackagePaymentParams(
            id: id,
            paymentMethod: paymentMethod,
            code: codeController.text,
            coachId: coachId.value)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (StripeEntity data) => {
                  // Get.find<AppController>().onItemTapped(1),
                  showFlutterToast(message: "success"),
                  paymentMethod == "stripe"
                      ? Get.to(() => WebViewApp(url: data.url))
                      : Get.find<AppController>().onItemTapped(1),
                });
    isLoading = false;
  }

  DiscountEntity discountEntity =
      DiscountEntity(discount: '', old_price: "", price: 0);

  RxBool discount = false.obs;

  checkPromoCode(int packageId) async {
    isLoading = true;
    (await baseCoachRepository.checkPromoCode(CheckPromoCodeParams(
            package_id: packageId, code: codeController.text)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (DiscountEntity data) =>
                {discount.value = true, discountEntity = data});
    isLoading = false;
  }

  RxString coachId = "".obs;

  @override
  void onInit() async {
    coachId.value = instance<AppPreferences>().getCoachEntity()[0];
    // coachIdPassed?.value = Get.arguments ?? Get.arguments["coachId"];
    await getShop();
    super.onInit();
  }
}
