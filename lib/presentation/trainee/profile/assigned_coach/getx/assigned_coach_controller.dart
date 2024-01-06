import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/profile/profile_repo/profile_repository.dart';
import '../../../../widgets/toasts_messages.dart';

class AssignedCoachController extends GetxController {
  BaseProfileRepository baseProfileRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<CoachEntity> coaches = [];

  getAssignedCoaches() async {
    isLoading = true;
    (await baseProfileRepository.getAssignedCoaches()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<CoachEntity> data) => {coaches = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getAssignedCoaches();
    super.onInit();
  }
}
