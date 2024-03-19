import 'package:flutter/material.dart';

class CustomNavigatorObserver extends RouteObserver<PageRoute<dynamic>> {
  final List<PageRoute<dynamic>> _history = [];
  final Widget screenName;

  CustomNavigatorObserver({required this.screenName});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute<dynamic>) {
      _history.add(route);
      if (_history.length > 4) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(route.navigator!.context)
              .removeRouteBelow(_history[_history.length - 5]);
          _history.removeRange(0, _history.length - 4);
        });
      }
      // else if (_history.length == 1) {
      //   Get.dialog(ConfirmChoiceDialog(
      //     title: 'Close App',
      //     message: 'Are you sure you want to close the app?',
      //     toDoButton: 'yes',
      //     toDo: () {
      //       SystemNavigator.pop();
      //     },
      //   ));
      // }
    }
  }
}
