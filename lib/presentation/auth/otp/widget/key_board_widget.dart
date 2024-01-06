import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/value_manager.dart';
import '../getx/otp_controller.dart';

class KeyBoardWidget extends GetView<OtpController> {
  const KeyBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * 0.73,
        height: Get.height * 0.32,
        decoration: BoxDecoration(
            color: ColorManager.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSize.s14)),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "3",
                      child: Text(
                        "3",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "2",
                      child: Text(
                        "2",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "1",
                      child: Text(
                        "1",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "6",
                      child: Text(
                        "6",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "5",
                      child: Text(
                        "5",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "4",
                      child: Text(
                        "4",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "9",
                      child: Text(
                        "9",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "8",
                      child: Text(
                        "8",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "7",
                      child: Text(
                        "7",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () => controller.codeController.text =
                              controller.codeController.text.substring(
                                  0, controller.codeController.text.length - 1),
                          child: const Icon(Icons.backspace_outlined))),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => controller.codeController.text += "0",
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.105,
                          ),
                          Text(
                            "0",
                            style: Theme.of(context).textTheme.titleLarge!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
