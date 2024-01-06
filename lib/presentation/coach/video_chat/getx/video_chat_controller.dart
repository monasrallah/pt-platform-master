import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/chat_entity.dart';
import 'package:pt_platform/presentation/coach/getx/coach_home_controller.dart';

import '../../../../app/dependency_injection.dart';
import '../../../../data/coach_app/coach_app_repo/coach_app_repository.dart';
import '../../../widgets/toasts_messages.dart';

class VideoChatCoachController extends GetxController {
  BaseCoachAppRepository baseCoachAppRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<ChatEntity> chats = [];

  getVideoChat() async {
    isLoading = true;
    (await baseCoachAppRepository
            .getVideoChat(Get.find<CoachHomeController>().coachId.value))
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<ChatEntity> data) => {chats = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getVideoChat();
    super.onInit();
  }
}
