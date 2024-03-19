import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/app/storage/app_prefs.dart';
import 'package:pt_platform/domain/entities/coach_entities/personalized_entity.dart';
import 'package:pt_platform/domain/entities/coach_entities/shop_entity.dart';
import 'package:pt_platform/domain/parameters/coach_params/get_apple_iap_id_prams.dart';
import 'package:pt_platform/domain/parameters/coach_params/purchase_iap_success.dart';
import 'package:pt_platform/presentation/trainee/coach/shop/util/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/app_controller.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../domain/parameters/coach_params/check_promo_code_params.dart';
import '../../../../../domain/parameters/coach_params/packege_payment_params.dart';
import '../../../../widgets/toasts_messages.dart';

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
                      ? launchUrl(Uri.parse(data.url))
                      : Get.find<AppController>().onItemTapped(1),
                });
    isLoading = false; //TODO
  }

  checkoutFree(int id, String paymentMethod) async {
    isLoading = true;
    (await baseCoachRepository.checkoutFree(PackagePaymentParams(
            id: id,
            paymentMethod: paymentMethod,
            code: codeController.text,
            coachId: coachId.value)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) => {
                  // Get.find<AppController>().onItemTapped(1),
                  showFlutterToast(message: "success"),
                  Get.find<AppController>().onItemTapped(1),
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

  String? _productAppleId;

  Future<void> iApCheckOut({
    required String productAppleId,
    required int id,
    required VoidCallback onSuccess,
  }) async {
    try {
      InAppPurchaseService iap = InAppPurchaseService();
      final productDetailsList = await iap.initialize(
        kProductIds: [productAppleId],
      );
      iap.listenToPurchaseUpdated(
        onSuccessPurchase: (purchaseDetails) async {
          log('success');
          await baseCoachRepository.purchaseIAPSuccess(
            PurchaseIapSuccessPrams(
              id: id,
              coachId: coachId.value,
              txnId: purchaseDetails.purchaseID!,
              promotionCode:
                  codeController.text.isNotEmpty ? codeController.text : null,
            ),
          );
          onSuccess();
        },
        onErrorPurchase: (error) {
          log('error');
          showFlutterToast(message: error);
        },
        onPendingPurchase: () {
          log('pending');
        },
        onRestoredPurchase: (purchaseDetails) {
          log('restored');
        },
        onCanceledPurchase: () {
          log('canceled');
        },
      );
      final result = await iap.buyNonConsumable(
        productDetails: productDetailsList[0],
      );
      if (!result) throw Exception("Error in purchase");
    } catch (e) {
      showFlutterToast(message: e.toString());
    }
  }

  Future<void> getAppleIAPId({
    required int id,
  }) async {
    final result = await baseCoachRepository.getAppleIAPId(
      GetAppleIapIdParams(
        id: id,
        coachId: coachId.value,
        paymentMethod: "purchase",
      ),
    );

    result.fold((l) {}, (r) {
      _productAppleId = r;
    });
  }

  appleCheckout({
    required int id,
    required VoidCallback onSuccess,
  }) async {
    isLoading = true;
    await getAppleIAPId(id: id);
    if (_productAppleId != null) {
      await iApCheckOut(
        productAppleId: _productAppleId!,
        id: id,
        onSuccess: onSuccess,
      );
    }
    isLoading = false;
  }
}
