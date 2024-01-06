import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/progress_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../../domain/entities/home_entities/measurements_entity.dart';
import '../../../../../resources/functions/date_format_function.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/trainee_controller.dart';

class ProgressCoachController extends GetxController {
  final ValueNotifier<Key> expanded = ValueNotifier(const Key("0"));
  BaseCoachAppRepository baseHomeRepository = instance();
  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<String> measurementsList = [
    "DATE",
    "NECK",
    "CHEST",
    "LEFT ARM",
    "RIGHT ARM",
    "WAIST",
    "BELLY",
    "LOWER BELLY",
    "UPPER BELLY",
    "HIPS",
    "LEFT THIGH",
    "RIGHT THIGH",
    "LEFT CALF",
    "RIGHT CALF",
  ];

  List<String> measurementsDialogList = [
    "NECK",
    "CHEST",
    "LEFT ARM",
    "RIGHT ARM",
    "WAIST",
    "BELLY",
    "LOWER BELLY",
    "UPPER BELLY",
    "HIPS",
    "LEFT THIGH",
    "RIGHT THIGH",
    "LEFT CALF",
    "RIGHT CALF",
  ];

  RxList<MeasurementsEntity> measurementsAmountList =
      <MeasurementsEntity>[].obs;

  RxList<String> measurementsAfterAmount = <String>[].obs;
  RxList<String> measurementsBeforeAmount = <String>[].obs;

  convertMeasurementAfterToString() {
    measurementsAfterAmount.value = [
      dateFormat(date: measurementsAmountList[0].date),
      measurementsAmountList[0].neck.toStringAsFixed(2),
      measurementsAmountList[0].chest.toStringAsFixed(2),
      measurementsAmountList[0].leftArm.toStringAsFixed(2),
      measurementsAmountList[0].rightArm.toStringAsFixed(2),
      measurementsAmountList[0].waist.toStringAsFixed(2),
      measurementsAmountList[0].belly.toStringAsFixed(2),
      measurementsAmountList[0].lowerBelly.toStringAsFixed(2),
      measurementsAmountList[0].upperBelly.toStringAsFixed(2),
      measurementsAmountList[0].hips.toStringAsFixed(2),
      measurementsAmountList[0].leftThigh.toStringAsFixed(2),
      measurementsAmountList[0].rightThigh.toStringAsFixed(2),
      measurementsAmountList[0].liftCalf.toStringAsFixed(2),
      measurementsAmountList[0].rightCalf.toStringAsFixed(2),
    ];
  }

  convertMeasurementBeforeToString() {
    measurementsBeforeAmount.value = [
      dateFormat(date: measurementsAmountList[1].date),
      measurementsAmountList[1].neck.toStringAsFixed(2),
      measurementsAmountList[1].chest.toStringAsFixed(2),
      measurementsAmountList[1].leftArm.toStringAsFixed(2),
      measurementsAmountList[1].rightArm.toStringAsFixed(2),
      measurementsAmountList[1].waist.toStringAsFixed(2),
      measurementsAmountList[1].belly.toStringAsFixed(2),
      measurementsAmountList[1].lowerBelly.toStringAsFixed(2),
      measurementsAmountList[1].upperBelly.toStringAsFixed(2),
      measurementsAmountList[1].hips.toStringAsFixed(2),
      measurementsAmountList[1].leftThigh.toStringAsFixed(2),
      measurementsAmountList[1].rightThigh.toStringAsFixed(2),
      measurementsAmountList[1].liftCalf.toStringAsFixed(2),
      measurementsAmountList[1].rightCalf.toStringAsFixed(2),
    ];
  }

  measurements() async {
    isLoading = true;
    (await baseHomeRepository
            .measurements(Get.find<TraineeCoachController>().traineeId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<MeasurementsEntity> data) => {
                  measurementsAmountList.value = data,
                  if (data.isNotEmpty)
                    {
                      convertMeasurementAfterToString(),
                      convertMeasurementBeforeToString()
                    },
                });
    isLoading = false;
  }

  RxList<ProgressEntity> progressAmount = <ProgressEntity>[].obs;

  progress() async {
    isLoading = true;
    (await baseHomeRepository
            .progress(Get.find<TraineeCoachController>().traineeId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ProgressEntity> data) =>
                {if (data.isNotEmpty) progressAmount.value = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await progress();
    await measurements();
    super.onInit();
  }
}
