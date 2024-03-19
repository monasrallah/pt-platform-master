import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

/// this class is used to implement in app purchase
class InAppPurchaseService {
  /// Instantiate IAP
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  /// Initialize your InApp purchases
  Future<List<ProductDetails>> initialize({
    required List<String> kProductIds,
  }) async {
    /// Check availability of InApp Purchases
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      /// The store cannot be reached or accessed. Update the UI accordingly.
      throw Exception('The store cannot be reached or accessed');
    }

    /// Load and fetch products
    final result = await _loadProducts(kProductIds: kProductIds);

    return result;
  }

  /// Load and fetch products from the IDs
  Future<List<ProductDetails>> _loadProducts({
    required List<String> kProductIds,
  }) async {
    final response =
        await _inAppPurchase.queryProductDetails(kProductIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      /// Handle the case when product IDs were not found

      throw Exception(
          'The following products were not found: ${response.notFoundIDs}');
    }
    if (response.error != null) {
      /// Handle errors occurred while fetching products details

      throw Exception(response.error!.message);
    }

    /// If we have products, you can display them to the user for purchase
    final products = response.productDetails;

    /// Display your products using your U
    return products;
  }

  /// Buy a consumable product
  Future<bool> buyNonConsumable({
    required ProductDetails productDetails,
  }) async {
    final purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );
    final result =
        await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    return result;
  }

  /// Buy a consumable product
  Future<bool> buyConsumable({
    required ProductDetails productDetails,
  }) async {
    final purchaseParam = PurchaseParam(
      productDetails: productDetails,
    );
    final result =
        await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    return result;
  }

  /// Complete purchase
  Future<void> completePurchase(PurchaseDetails purchaseDetails) async {
    await _inAppPurchase.completePurchase(purchaseDetails);
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }

  /// Listen to the purchase updates
  Future<void> listenToPurchaseUpdated({
    required OnSuccessPurchase onSuccessPurchase,
    required OnErrorPurchase onErrorPurchase,
    required OnPendingPurchase onPendingPurchase,
    required OnRestoredPurchase onRestoredPurchase,
    required OnCanceledPurchase onCanceledPurchase,
  }) async {
    /// cancel the previous subscription
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        for (final purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails.status == PurchaseStatus.pending) {
            log('pending');
            onPendingPurchase();
          }
          if (purchaseDetails.status == PurchaseStatus.error) {
            log('error');
            completePurchase(purchaseDetails);
            onErrorPurchase(purchaseDetails.error!.message);
          }
          if (purchaseDetails.status == PurchaseStatus.purchased) {
            log('purchased');
            completePurchase(purchaseDetails);
            onSuccessPurchase(purchaseDetails);
          }
          if (purchaseDetails.status == PurchaseStatus.restored) {
            log('restored');
            completePurchase(purchaseDetails);
            onRestoredPurchase(purchaseDetails);
          }
          if (purchaseDetails.status == PurchaseStatus.canceled) {
            log('canceled');
            completePurchase(purchaseDetails);
            onCanceledPurchase();
          }
        }
      },
      onDone: () {
        log('onDone');
      },
      onError: (Object error) {
        log('onError');
        onErrorPurchase(error.toString());
      },
      cancelOnError: false,
    );
  }

  /// Close the subscription
  void closeSubscription() {
    _subscription.cancel();
  }

  /// Open subscription management page
  Future<void> openSubscriptionManagementPage() async {
    final uri = Platform.isIOS
        ? Uri(
            scheme: 'https',
            host: 'apps.apple.com',
            path: 'account/subscriptions',
          )
        : Uri(
            scheme: 'https',
            host: 'play.google.com',
            path: 'store/account/subscriptions',
          );
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch $uri');
    }
  }
}

/// Callback to handle purchase success
typedef OnSuccessPurchase = void Function(PurchaseDetails purchaseDetails);

/// Callback to handle purchase error
typedef OnErrorPurchase = void Function(String error);

/// Callback to handle purchase pending
typedef OnPendingPurchase = void Function();

/// Callback to handle purchase restored
typedef OnRestoredPurchase = void Function(PurchaseDetails purchaseDetails);

/// Callback to handle purchase canceled
typedef OnCanceledPurchase = void Function();
