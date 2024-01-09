import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../../widgets/toasts_messages.dart';
import '../../getx/trainee_controller.dart';

class KycCoachController extends GetxController {
  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  RxList<FaqsEntity> kyc = <FaqsEntity>[].obs;

  getKyc() async {
    isLoading = true;
    (await baseCoachAppRepository
            .kyc(Get.find<TraineeCoachController>().traineeId.value))
            // .kyc("50"))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<FaqsEntity> data) => {kyc.value = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getKyc();
    super.onInit();
  }
}
