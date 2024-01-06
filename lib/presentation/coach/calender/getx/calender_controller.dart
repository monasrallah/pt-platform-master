import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_app_entity/calender_entity.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../widgets/toasts_messages.dart';

class CalenderCoachController extends GetxController {
  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<CalenderCoachEntity> calenders = [];

  getCoachCalendar() async {
    isLoading = true;
    (await baseCoachAppRepository.getCoachCalendar()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<CalenderCoachEntity> data) => {calenders = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getCoachCalendar();
    super.onInit();
  }
}
