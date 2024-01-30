// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/Personalized/personal_training/getx/personal_training_controller.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/presentation/trainee/coach/shop/getx/shop_controller.dart';
import 'package:pt_platform/presentation/trainee/home/news/getx/news_controller.dart';
import 'package:pt_platform/presentation/trainee/home/trainer/getx/trainer_controller.dart';
import 'package:pt_platform/providers/notifications_provider.dart';

import '../resources/language_manger.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import 'app_controller.dart';

class MyApp extends StatelessWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  bool light = true;
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932), //1800
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            getPages: AppPages.pages,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splashRoute,
            initialBinding: RootBinding(),
            translations: LocalizationService(),
            theme: getDarkTheme(),
            locale: LocalizationService.getLocaleFromLanguage(
                Get.find<AppController>().lang),
            localizationsDelegates: localization.localizationsDelegates,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            // navigatorObservers: [
            //   CustomNavigatorObserver(
            //     screenName: const HomeView(),
            //   )
            // ],
          );
        });
  }
}

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsProvider());
    Get.put(CoachController());
    Get.put(NewsController());
    Get.put(PersonalTrainingController());
    Get.put(ShopController());
    Get.put(TrainerController());
  }
}
