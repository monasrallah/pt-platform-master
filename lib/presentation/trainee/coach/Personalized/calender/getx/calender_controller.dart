import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/debug/log.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/calender_entity.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/resources/functions/date_format_function.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../app/storage/app_prefs.dart';
import '../../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../../domain/parameters/coach_params/add_calender_params.dart';
import '../../../../../../domain/parameters/coach_params/date_coach_id_params.dart';
import '../../../../../widgets/toasts_messages.dart';
import '../widget/request_sent.dart';

class CalenderController extends GetxController {
  final Rx<DateTime> _currentDate = DateTime.now().obs;

  DateTime get currentDate => _currentDate.value;

  set currentDate(DateTime value) {
    _currentDate.value = value;
  }

  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  RxList<CalenderEntity> calenders = <CalenderEntity>[
    // CalenderEntity(id: 1, time: "time1", isAutoAccept: true, isAvailable: true),
    // CalenderEntity(
    //     id: 2, time: "time2", isAutoAccept: false, isAvailable: false),
    // CalenderEntity(id: 3, time: "time3", isAutoAccept: true, isAvailable: true),
  ].obs;

  RxBool timeSelected = false.obs;
  RxInt timeIdSelected = 0.obs;
  RxString selectedTime = "".obs;

  getCoachCalendar() async {
    isLoading = true;
    (await baseCoachRepository.getCoachCalendar(DateCoachIdParams(
            date: dateFormat(date: currentDate),
            coachId: Get.find<CoachController>().coachId.value)))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<CalenderEntity> data) => {calenders.value = data});
    isLoading = false;
  }

  DateTime mergeDateAndTime(String dateStr, String timeStr) {
    // Parse the date and time strings
    DateTime date = DateTime.parse(dateStr);
    TimeOfDay timeOfDay =
        TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 $timeStr"));

    // Combine the date and time
    DateTime resultDateTime = DateTime(
        date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);

    return resultDateTime;
  }

  Event buildEvent({Recurrence? recurrence}) {
    print(selectedTime.value);
    print(currentDate);
    return Event(
      title: 'Meeting with ${coachName.value} ',
      description: 'online session',
      location: 'Zoom video call',
      startDate: mergeDateAndTime(currentDate.toString(), selectedTime.value),
      endDate: mergeDateAndTime(currentDate.toString(), selectedTime.value)
          .add(const Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  void addToDeviceCalendar() {
    Add2Calendar.addEvent2Cal(
      buildEvent(),
    );
  }

  addCoachCalendar() async {
    isLoading = true;
    if (timeSelected.value) {
      (await baseCoachRepository.addCoachCalendar(AddCalenderParams(
              timeId: timeIdSelected.value,
              coachId: Get.find<CoachController>().coachId.value)))
          .fold(
              (failure) => showFlutterToast(message: failure.message.orEmpty()),
              (data) => {Get.to(() => const RequestSentPage())});
    } else {
      showFlutterToast(message: "Please select time");
    }

    isLoading = false;
  }

  RxString coachName = "".obs;
  RxString coachAvatar = "".obs;

  @override
  void onInit() async {
    coachName.value = instance<AppPreferences>().getCoachEntity().length > 1
        ? instance<AppPreferences>().getCoachEntity()[1]
        : "";
    coachAvatar.value = instance<AppPreferences>().getCoachEntity().length > 2
        ? instance<AppPreferences>().getCoachEntity()[2]
        : "";
    await getCoachCalendar();
    super.onInit();
  }
}
