import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pt_platform/app/dependency_injection.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/app/storage/app_prefs.dart';
import 'package:pt_platform/resources/routes_manager.dart';

// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

import '../data/coach/coach_repo/coach_repository.dart';
import '../domain/entities/auth_entities/coach_entity.dart';
import '../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../presentation/trainee/coach/getx/coach_controller.dart';
import '../presentation/widgets/dialogs/add_to_log_dialog.dart';
import '../presentation/widgets/dialogs/confirm_choice_dialog.dart';
import '../presentation/widgets/toasts_messages.dart';

class AppController extends GetxController {
  final Rx<CoachEntity> _user = CoachEntity.init().obs;

  CoachEntity get user => _user.value;

  set user(CoachEntity value) {
    _user.value = value;
  }

  final RxInt _selectedIndex = 1.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) {
    _selectedIndex.value = value;
  }

  Rx<Widget?>? selectedPage = Container().obs;
  String defaultImage =
      "https://www.pngitem.com/pimgs/m/551-5510463_default-user-image-png-transparent-png.png";

  List<String> pages = <String>[
    Routes.homeRoute,
    Routes.coachRoute,
    Routes.profileRoute,
  ];

  void onItemTapped(int index) {
    selectedIndex = index;

    Get.offAllNamed(
      pages[selectedIndex],
      // transition: Transition.fadeIn,
      // duration: const Duration(milliseconds: 500)
    );
  }

  openConfirmationDialog() {
    Get.dialog(ConfirmChoiceDialog(
      title: 'Close App',
      message: 'Are you sure you want to close the app?',
      toDoButton: 'yes',
      toDo: () {
        SystemNavigator.pop();
      },
    ));
  }

  String getLinkInfo({required int index, required String htmlText}) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(htmlText);
    String link = "";
    for (var match in matches) {
      link = htmlText.substring(match.start, match.end);
      // print(supplements[index].description.substring(match.start, match.end));
    }
    return link;
  }

  List<TextEditingController> textLogControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  openLogDialog({required int videoId}) {
    showAdaptiveDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AddToLogDialog(
            sets: 10,
            weightUnit: const ["Pound", "Kilogram", "Stone"],
            textController: textLogControllers,
            onTap: () async {
              await addToLogVideo(videoId);
            },
          );
        });
  }

  addToLogVideo(int videoId) async {
    BaseCoachRepository baseCoachRepository = instance();
    print("ghina1 ${textLogControllers[3].text}");
    (await baseCoachRepository.addToLogVideo(AddVideoToLogParams(
            videoId: videoId,
            coachId: Get.find<CoachController>().coachId.value,
            number: int.parse(textLogControllers[0].text),
            weight: int.parse(textLogControllers[2].text),
            weightUnit: textLogControllers[1].text.toLowerCase(),
            repetition: int.parse(textLogControllers[3].text),
            note: textLogControllers[4].text,
            type: 'exercise')))
        .fold(
            (failure) => showFlutterToast(message: failure.message!.orEmpty()),
            (data) => {});
  }

  // late Map<String, tz.Location> locations;
  String timeZone = "";
  String version = "";

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    version = info.version;
  }

  // print(locations.length); // => 429
  // print(locations.keys.first); // => "Africa/Abidjan"
  // print(locations.keys.last); // => "US/Pacific"

  String lang = "";

  String getLang() {
    lang = instance<AppPreferences>().getAppLanguage();
    return lang;
  }

  @override
  Future<void> onInit() async {
    lang = getLang();
    // tz.initializeTimeZones();
    // locations = tz.timeZoneDatabase.locations;
    final localTimeZone = await FlutterTimezone.getLocalTimezone();
    timeZone = localTimeZone;
    await _initPackageInfo();
    super.onInit();

    // await getUserProfileToken();
  }
}
