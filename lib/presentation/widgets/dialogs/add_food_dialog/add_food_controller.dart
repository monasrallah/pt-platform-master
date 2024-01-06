import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/home/home_repo/home_repository.dart';
import '../../../../domain/entities/home_entities/food_entity.dart';
import '../../../../domain/parameters/home_params/get_food_params.dart';
import '../../toasts_messages.dart';

class AddFoodController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();
  RxInt selected = 0.obs;
  RxInt skip = 0.obs;
  TextEditingController search = TextEditingController();
  RefreshController refreshController = RefreshController();
  RxList<AddFoodEntity> searchList = <AddFoodEntity>[].obs;

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  getFood(int skip) async {
    isLoading = true;
    (await baseHomeRepository
            .getFood(GetFoodsParams(search: search.text, skip: skip)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<AddFoodEntity> data) => {
              searchList.clear(),
              searchList.value = data,
                });
    isLoading = false;
    // search.clear();
  }

  onLoading() async {
    // isLoading = true;
    (await baseHomeRepository.getFood(
            GetFoodsParams(search: search.text, skip: skip.value += 15)))
        .fold(
            (failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<AddFoodEntity> data) => {
                  searchList.addAll(data),
                  if (data.isEmpty) {refreshController.loadNoData()}
                });

    refreshController.loadComplete();
    // isLoading = false;

    // var resgionsRes = await transactionUseCase(
    //     TransactionParam(pageNumber: currentPage, filter: ''));
    // resgionsRes.fold((l) {
    //   AppSnackBar.openErrorSnackBar(message: "errorLoading".tr + l.toString());
    //   log('error $l');
    // }, (r) {
    //   totalPage = r.lastPage!;
    //   for (var element in r.data!) {
    //     TransactionModel orderModel = TransactionModel.fromJson(element);
    //     transactions.add(orderModel.toDomain());
    //   }
    //   currentPage = currentPage + 1;
    //   if (r.data!.isEmpty) {
    //     refreshController.loadNoData();
    //   }
    // });

    // refreshController.loadComplete();
  }

//
// filterList(List<AddFoodEntity> titles) {
//   searchList.clear();
//   for (var p in titles) {
//     if (p.name.toLowerCase().contains(search.text)) {
//       searchList.add(p);
//     }
//   }
// }
}
