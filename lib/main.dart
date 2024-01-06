import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      options: GetPlatform.isAndroid
          ? const FirebaseOptions(
              apiKey: "XXX",
              appId: "XXX",
              messagingSenderId: "XXX",
              projectId: "XXX",
            )
          : null);
  await init();

  runApp(MyApp());
}
