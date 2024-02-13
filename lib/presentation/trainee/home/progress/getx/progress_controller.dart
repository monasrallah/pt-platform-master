import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/measurements_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/progress_entity.dart';
import 'package:pt_platform/domain/parameters/home_params/update_measurements_params.dart';
import 'package:pt_platform/resources/functions/date_format_function.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../domain/parameters/home_params/update_progress_params.dart';
import '../../../../widgets/toasts_messages.dart';

class ProgressController extends GetxController {
  final ValueNotifier<Key> expanded = ValueNotifier(const Key("0"));
  BaseHomeRepository baseHomeRepository = instance();
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
    (await baseHomeRepository.measurements()).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (List<MeasurementsEntity> data) => {
              measurementsAmountList.value = data,
              if (data.isNotEmpty)
                {
                  convertMeasurementAfterToString(),
                  convertMeasurementBeforeToString()
                }
              else
                {
                  measurementsAmountList.value = [
                    MeasurementsEntity.init(),
                    MeasurementsEntity.init()
                  ],
                  convertMeasurementAfterToString(),
                  convertMeasurementBeforeToString()
                }
            });
    isLoading = false;
  }

  List<TextEditingController> listOfMeasurementsController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  updateMeasurements() async {
    isLoading = true;
    (await baseHomeRepository.updateMeasurements(UpdateMeasurementsParams(
      neck: double.parse(listOfMeasurementsController[0].text),
      chest: double.parse(listOfMeasurementsController[1].text),
      left_arm: double.parse(listOfMeasurementsController[2].text),
      right_arm: double.parse(listOfMeasurementsController[3].text),
      waist: double.parse(listOfMeasurementsController[4].text),
      belly: double.parse(listOfMeasurementsController[5].text),
      lower_belly: double.parse(listOfMeasurementsController[6].text),
      upper_belly: double.parse(listOfMeasurementsController[7].text),
      hips: double.parse(listOfMeasurementsController[8].text),
      left_thigh: double.parse(listOfMeasurementsController[9].text),
      right_thigh: double.parse(listOfMeasurementsController[10].text),
      lift_calf: double.parse(listOfMeasurementsController[11].text),
      right_calf: double.parse(listOfMeasurementsController[12].text),
    )))
        .fold(
            (failure) => showFlutterToast(message: failure.message!.orEmpty()),
            (data) async => {await measurements(), Get.back() , clearFiled()});
    isLoading = false;
  }

  clearFiled(){
    for(int index = 0 ; index < listOfMeasurementsController.length ; index ++){
      listOfMeasurementsController[index].clear();
    }
  }
  RxList<ProgressEntity> progressAmount = [
    ProgressEntity.init(),
    ProgressEntity.init(),
    ProgressEntity.init(),
    ProgressEntity.init(),
    ProgressEntity.init(),
    ProgressEntity.init(),
  ].obs;

  progress() async {
    isLoading = true;
    (await baseHomeRepository.progress()).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (List<ProgressEntity> data) =>
            {if (data.isNotEmpty) progressAmount.value = data});
    isLoading = false;
  }

  List<TextEditingController> listOfController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  updateProgress() async {
    isLoading = true;
    (await baseHomeRepository.updateProgress(UpdateProgressParams(
      weight: double.parse(listOfController[0].text),
      muscle: double.parse(listOfController[1].text),
      fat: double.parse(listOfController[2].text),
      water: double.parse(listOfController[3].text),
      active_calories: double.parse(listOfController[4].text),
      steps: double.parse(listOfController[5].text),
    )))
        .fold(
            (failure) => showFlutterToast(message: failure.message!.orEmpty()),
            (data) async => {await progress(), Get.back()});
    isLoading = false;
  }

  @override
  void onInit() async {
    await progress();
    await measurements();
    super.onInit();
  }
}
