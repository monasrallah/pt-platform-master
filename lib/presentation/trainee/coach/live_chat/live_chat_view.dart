import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/domain/entities/coach_entities/message_entity.dart';
import 'package:pt_platform/presentation/trainee/coach/getx/coach_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/app_back_bar.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/text_fields/custom_text_field.dart';
import '../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'getx/live_chat_controller.dart';
import 'widget/message_card.dart';

class LiveChatView extends GetView<LiveChatController> {
  const LiveChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.liveChat.tr),
      bodyWidget: buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildSendMessageBar(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: StreamBuilder<Object>(
          stream: controller.chatService.getMessages(
              int.parse(controller.coachController.coachId.value),
              int.parse(controller.coachController.userId.value)),
          builder: (context, AsyncSnapshot<Object> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if ((snapshot.data as DatabaseEvent).snapshot.value != null) {
              // Access the data from the snapshot
              controller.messageEntity.clear();
              controller.messages.value =
                  (snapshot.data as DatabaseEvent).snapshot.value as Map;

              // Do something with the data
              print("Received data: ${controller.messages}");

              if (controller.messageEntity.isEmpty) {
                controller.messages.forEach((key, innerMap) {
                  // Access data from innerMap
                  int receiverId = innerMap['receiver_id'];
                  var time = innerMap['time'];
                  String message = innerMap['message'];
                  int senderId = innerMap['sender_id'];

                  // Create MessageEntity object
                  MessageEntity messageEntity = MessageEntity(
                    receiver_id: receiverId,
                    time: time is int ? time : 0,
                    // Handle the case where 'time' is not an int
                    message: message,
                    sender_id: senderId,
                  );

                  // Add MessageEntity object to the list
                  controller.messageEntity.add(messageEntity);
                });

                controller.messageEntity
                    .sort((a, b) => b.time.compareTo(a.time));

                // Print the result
                // for (var messageEntity in controller.messageEntity) {
                //   print(' Message: ${messageEntity.message}');
                // }
              }
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.messageEntity.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return MessageCard(
                    color: controller.messageEntity[index].sender_id ==
                            int.parse(Get.find<CoachController>().coachId.value)
                        ? ColorManager.primary
                        : ColorManager.primaryDark,
                    message: controller.messageEntity[index].message,
                  );
                },
              ),
            );
          }),
    );
  }

  Widget buildSendMessageBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: 50.h,
              width: 0.75.sw,
              decoration: BoxDecoration(
                color: ColorManager.rangeSliderColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.r),
                // border: Border.all(color: ColorManager.white)
              ),
              child: CustomTextField(
                hint: '',
                textEditingController: controller.messageController,
                isUnderLineBorderStyle: true,
                suffixIcon: TextButton(
                  onPressed: () {
                    if (controller.messageController.text.isNotEmpty) {
                      controller.handleSubmitted(
                          int.parse(controller.coachController.coachId.value),
                          int.parse(controller.coachController.userId.value));
                    } else {
                      print(controller.messageController.text);
                    }
                  },
                  child: Text(
                    AppStrings.send.tr,
                    style: Get.textTheme.headlineMedium!
                        .copyWith(fontSize: 18.sp, color: ColorManager.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
