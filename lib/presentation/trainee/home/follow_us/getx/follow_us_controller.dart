import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUsController extends GetxController {
  String facebookUrl = "https://web.facebook.com/profile.php?id=100083373336595";
  String instagramUrl = "https://www.instagram.com/pt.platform/";

  Future<void> launchFacebook(String facebookUrl) async {
    // final facebookUrl = 'fb://facewebmodal/f?href=https://www.facebook.com/';
    const fallbackUrl = 'https://www.facebook.com/';
    if (await canLaunchUrl(Uri.parse(facebookUrl))) {
      await launchUrl(Uri.parse(facebookUrl));
    } else {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  }

  Future<void> launchInstagram(String instagramUrl) async {
    // final instagramUrl = 'instagram://user?username=USERNAME';
    const fallbackUrl = 'https://www.instagram.com/USERNAME';
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  }

}
