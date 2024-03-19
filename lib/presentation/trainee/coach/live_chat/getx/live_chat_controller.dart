import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/core/utils/chat/chat_service.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';

import '../../../../../domain/entities/coach_entities/message_entity.dart';

class LiveChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ChatService chatService = ChatService();
  RxMap<dynamic, dynamic> messages = <dynamic, dynamic>{}.obs;

  RxList<MessageEntity> messageEntity = <MessageEntity>[].obs;
  CoachController coachController = Get.find<CoachController>();

  void handleSubmitted(int coachId, int traineeId) async {
    var user = auth.currentUser;
    chatService.sendMessage(
        receiverId: coachId,
        senderId: traineeId,
        text: messageController.text,
        coachId: coachId,
        traineeId: traineeId);
    messageController.clear();

    // await chatService.listenForMessages("4", "50");
  }

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    isLoading = true;
    // messages.value = chatService.getMessages(
    //     Get.find<CoachController>().coachId.value.toString(), "50");
    // print("baba ${messages.length}");
    // if (messageEntity.isEmpty) {
    // chatService.listenForMessages("4", "50");
    // } else {
    //   messageEntity[messageEntity.length - 1] =
    //       chatService.listenForMessages("4", "50");
    //   print("waaaaw");
    // }

    isLoading = false;
    super.onInit();
  }
}
