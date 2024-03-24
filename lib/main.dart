import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pt_platform/firebase_options.dart';

import 'app/app.dart';
import 'app/dependency_injection.dart';

int? selectedCaptain;

void selectCaptain(int index) {
  print("selectCaptain");

  selectedCaptain = index;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initOneSignal();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);

  // Check if you received the link via `getInitialLink` first
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
  }
  FirebaseDynamicLinks.instance.onLink.listen(
    (pendingDynamicLinkData) {
      // Set up the `onLink` event listener next as it may be received here
      final Uri deepLink = pendingDynamicLinkData.link;
      // Example of using the dynamic link to push the user to a different screen
    },
  );
  await init();

  runApp(MyApp());
}

Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('592316cd-ef7f-44c2-83af-00051ed3783f');
  OneSignal.Notifications.requestPermission(true);
}
