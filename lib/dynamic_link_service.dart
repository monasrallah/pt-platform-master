import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:pt_platform/resources/routes_manager.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    await Future.delayed(const Duration(seconds: 5));
    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData dynamicLink) async {
      // handle link that has been retrieved
      _handleDeepLink(dynamicLink);
    }).onError((error) async {});
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    // handle link that has been retrieved
    _handleDeepLink(data);
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      var isService = deepLink.path.contains('show');
      if (isService) {
        // var id = deepLink.queryParameters['title'];
        //var serviceId = deepLink.pathSegments.last;
        var serviceId = deepLink.path.split('/show/')[1];
        //var serviceId = deepLink.pathSegments.sublist(40);
        if (serviceId.isNotEmpty) {
          // _navigationService.navigateTo(CreatePostViewRoute, arguments: title);
          Get.toNamed(Routes.splashRoute);
        }
      } else {
        Get.toNamed(Routes.splashRoute);
      }
    }
  }

  Future<String> createStarLink(
      {String? title, String? description, Uri? uri}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://ptplatform.page.link',
      //uriPrefix: 'https://nbeplatinumapp.page.link',
      link: Uri.parse('https://com.smartedge.ptapp/'),
      // 'https://linkalintest.com/nbe_platinum/star/$starId?ofl=https://play.google.com/store'),
      androidParameters: const AndroidParameters(
        packageName: 'com.smartedge.ptapp',
        minimumVersion: 1,
      ),
      // Other things to add as an example. We don't need it now
      iosParameters: const IOSParameters(
        bundleId: 'com.smartedge.ptapp',
        minimumVersion: '1',
        appStoreId: '123456789',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        imageUrl: uri,
        description: description,
      ),
    );
    // final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri dynamicUrl = shortDynamicLink.shortUrl;
    return dynamicUrl.toString();
  }
}
