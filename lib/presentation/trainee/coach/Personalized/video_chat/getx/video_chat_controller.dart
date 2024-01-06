import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/coach_entities/chat_entity.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';

import '../../../../../../app/dependency_injection.dart';
import '../../../../../../data/coach/coach_repo/coach_repository.dart';
import '../../../../../widgets/toasts_messages.dart';

class VideoChatController extends GetxController {
  BaseCoachRepository baseCoachRepository = instance();

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  List<ChatEntity> chats = [];

  getVideoChat() async {
    isLoading = true;
    (await baseCoachRepository
            .getVideoChat(Get.find<CoachController>().coachId.value))
        .fold(
            (failure) => showFlutterToast(message: failure.message!.orEmpty()),
            (List<ChatEntity> data) => {chats = data});
    isLoading = false;
  }

  deleteVideoChat(int id) async {
    isLoading = true;
    (await baseCoachRepository.deleteVideoChat(id)).fold(
        (failure) => showFlutterToast(message: failure.message!.orEmpty()),
        (data) => {});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getVideoChat();
    super.onInit();
  }
}
