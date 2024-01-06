import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalorieCalculatorController extends GetxController {
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  RxBool isMale = true.obs;
  RxBool visible = false.obs;
  RxString active = "".obs;
  List<String> actives = [
    'Less than 3 times/week',
    'Sports 1-3 times/week',
    'Sports 3-5 times/week',
    'Sports 6-7 times/week',
    'More than 7/a week',
  ];

  RxBool ageValid = true.obs;
  RxBool heightValid = true.obs;
  RxBool weightValid = true.obs;
  RxBool activeValid = true.obs;

  bool allValid() {
    ageValid.value = age.text.isNotEmpty &&
        (int.parse(age.text) > 10 && int.parse(age.text) < 90);
    weightValid.value = weight.text.isNotEmpty &&
        (int.parse(weight.text) > 30 && int.parse(weight.text) < 150);
    heightValid.value = height.text.isNotEmpty &&
        (int.parse(height.text) > 100 && int.parse(height.text) < 250);
    activeValid.value = active.value.isNotEmpty;

    return ageValid.value &&
        weightValid.value &&
        heightValid.value &&
        activeValid.value;
  }

  RxDouble bMR = 0.0.obs;
  RxDouble value = 0.0.obs;

  calculate() {
    if (allValid()) {
      bMR.value = isMale.value
          ? ((10 * int.parse(weight.text)) +
              (6.25 * int.parse(height.text)) -
              (5 * int.parse(age.text)) +
              5)
          : ((10 * int.parse(weight.text)) +
                  (6.25 * int.parse(height.text)) -
                  (5 * int.parse(age.text)) -
                  161)
              .toDouble();
      int index = actives.indexOf(active.value);

      value.value = bMR.value *
          (index == 0
              ? 1.2
              : index == 1
                  ? 1.375
                  : index == 2
                      ? 1.55
                      : index == 3
                          ? 1.725
                          : 1.9);

      visible.value = true;
    }
  }
}
