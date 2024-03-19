import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../resources/color_manager.dart';

showFlutterToast({required String message}) {
  return Fluttertoast.showToast(
      backgroundColor: ColorManager.darkGrey,
      msg: message,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG);
}
