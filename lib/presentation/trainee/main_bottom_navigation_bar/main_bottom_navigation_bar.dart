import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/strings_manager.dart';
import 'getx/main_bottom_navigation_bar_controller.dart';

class MainBottomNavigationBar
    extends GetView<MainBottomNavigationBarController> {
  const MainBottomNavigationBar(
      {required this.bodyWidget,
      this.appBarWidget,
      this.backgroundColor,
      this.floatingActionButtonLocation,
      this.floatingActionButton,
      Key? key})
      : super(key: key);
  final Widget bodyWidget;
  final PreferredSizeWidget? appBarWidget;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBarWidget,
      body: bodyWidget,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      // controller
      //     .appController.pages[controller.appController.selectedIndex]
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
              label: AppStrings.home.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center),
              label: AppStrings.coach.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: AppStrings.profile.tr,
            ),
          ],
          currentIndex: controller.appController.selectedIndex,
          onTap: controller.appController.onItemTapped,
        ),
      ),
    );
  }
}
