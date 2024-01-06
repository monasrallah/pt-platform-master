import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../domain/entities/coach_app_entity/user_entity.dart';
import '../../../widgets/toasts_messages.dart';

class PersonalTrainingCoachController extends GetxController {
  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<UserEntity> users = [];

  getUsers() async {
    isLoading = true;
    (await baseCoachAppRepository.getUsers()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<UserEntity> data) => {users = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getUsers();
    super.onInit();
  }
}
