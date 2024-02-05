import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/food_entity.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../data/home/home_repo/home_repository.dart';
import '../../../../../../domain/parameters/home_params/add_food_params.dart';
import '../../../../../../domain/parameters/home_params/get_food_params.dart';
import '../../../../../../domain/parameters/home_params/update_target_params.dart';
import '../../../../../../resources/functions/date_format_function.dart';
import '../../../../../widgets/dialogs/confirm_choice_dialog.dart';
import '../../../../../widgets/toasts_messages.dart';
import '../widget/edit_target_page.dart';

class FoodController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController calories = TextEditingController();
  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  final RxBool _isDeleteLoading = false.obs;

  set isDeleteLoading(bool val) => _isDeleteLoading.value = val;

  bool get isDeleteLoading => _isDeleteLoading.value;

  RxString date = dateFormat(date: DateTime.now()).obs;
  DateTime selectedDate = DateTime.now();

  RxString foodSelected = "".obs;

  RxInt foodId = 0.obs;

  RxInt counter = 1.obs;
  TextEditingController counterString = TextEditingController(text: "10");
  RxBool isPress = false.obs;

  void increase() {
    counter.value = int.parse(counterString.text);
    if (isPress.value) {
      counter += 10;
      counterString.text = counter.value.toString();
      Future.delayed(const Duration(milliseconds: 200), () {
        increase();
      });
    }
  }

  void decrease() {
    counter.value = int.parse(counterString.text);
    if (isPress.value) {
      if (counter > 1) {
        counter -= 10;
        counterString.text = counter.value.toString();
        Future.delayed(const Duration(milliseconds: 200), () {
          decrease();
        });
      }
    }
  }

  Rx<FoodEntity> foodEntity = FoodEntity.init().obs;

  List<AddFoodEntity> addFoods = [];
  Rx<AddFoodEntity> selectedFood = AddFoodEntity.init().obs;

  getFood({String? search, int? skip}) async {
    isLoading = true;
    (await baseHomeRepository.getFood(GetFoodsParams(search: '', skip: 0)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<AddFoodEntity> data) => {
                  addFoods = data,
                  if (data.isNotEmpty)
                    {
                      selectedFood.value = data[0],
                      calculateFood(),
                      foodSelected.value = selectedFood.value.title,
                      foodId.value = selectedFood.value.id
                    }
                });
    isLoading = false;
  }

  addFood(String type) async {
    isLoading = true;
    (await baseHomeRepository.addFood(AddFoodsParams(
        date:"${DateTime.now().year}-${DateTime.now().month}-${(DateTime.now().day)}" ,

        food_id: foodId.value,
            type: type,
            number: int.parse(counterString.text))))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (data) async => {await getFoodHistory(), Get.back()});
    isLoading = false;
  }

  openDeleteDialog(int foodId, String food) {
    Get.dialog(ConfirmChoiceDialog(
      title: 'Delete Food',
      message: 'Are you sure you want to delete $food?',
      toDoButton: 'yes',
      toDoCancel: () async {
        await getFoodHistory();
      },
      toDo: () async {
        await deleteFood(foodId);
        await getFoodHistory();
      },
    ));
  }

  deleteFood(int foodId) async {
    isDeleteLoading = true;
    (await baseHomeRepository.deleteFood(foodId)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) async => {});
    isDeleteLoading = false;
  }

  editTarget(UpdateTargetParams updateTargetParams) async {
    isLoading = true;
    (await baseHomeRepository.updateTarget(updateTargetParams)).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (data) async => {Get.back(), await getFoodHistory()});
    isLoading = false;
  }

  getFoodHistory() async {
    isLoading = true;
    (await baseHomeRepository.getFoodHistory(date.value)).fold((failure) {
      if (failure.message!.contains("Please Set Target Values")) {
        Get.to(() => EditTargetPage(
              foodEntity: FoodEntity.init(),
            ));
      }
      return showFlutterToast(message: failure.message.orEmpty());
    }, (FoodEntity data) => {foodEntity.value = data});
    isLoading = false;
  }

  calculatorNewTarget() {
    calories.text = (4 * int.parse(carbs.text.isEmpty ? "0" : carbs.text) +
            9 * int.parse(fat.text.isEmpty ? "0" : fat.text) +
            4 * int.parse(protein.text.isEmpty ? "0" : protein.text))
        .toString();
  }

  RxString proteinFood = "".obs;
  RxString fatFood = "".obs;
  RxString carbsFood = "".obs;
  RxString calorieFood = "".obs;

  calculateFood() {
    proteinFood.value =
        ((selectedFood.value.protein / 100) * int.parse(counterString.text))
            .toStringAsFixed(1);

    fatFood.value =
        ((selectedFood.value.fat / 100) * int.parse(counterString.text))
            .toStringAsFixed(1);

    carbsFood.value =
        ((selectedFood.value.carb / 100) * int.parse(counterString.text))
            .toStringAsFixed(1);

    calorieFood.value =
        ((selectedFood.value.calorie / 100) * int.parse(counterString.text))
            .toStringAsFixed(1);
  }

  @override
  void onInit() async {
    await getFoodHistory();

    // carbs.addListener(() {
    //   calories.text = (
    //           // int.parse(calories.text.isEmpty ? "0" : calories.text) +
    //           4 * int.parse(carbs.text))
    //       .toString();
    // });
    // fat.addListener(() {
    //   calories.text = (
    //           // int.parse(calories.text.isEmpty ? "0" : calories.text) +
    //           9 * int.parse(fat.text))
    //       .toString();
    // });
    // protein.addListener(() {
    //   calories.text = (
    //           //int.parse(calories.text.isEmpty ? "0" : calories.text) +
    //           4 * int.parse(protein.text))
    //       .toString();
    // });
    super.onInit();
  }
}
