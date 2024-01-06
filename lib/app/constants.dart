//flutter pub run build_runner build

import 'package:flutter/material.dart';
import 'package:pt_platform/resources/assets_manager.dart';

import '../data/coach/models/shop_model.dart';

class Constants {
  static const String empty = "";
  static const int zero = 0;
  static const int apiTimeOut = 60000;

  static Map<Style, String> shopImage = {
    Style.STYLE_GOLD: ImageAssets.gold,
    Style.STYLE_SILVER: ImageAssets.silver,
    Style.STYLE_BRONZE: ImageAssets.bronze,
    Style.STYLE_FREE: ImageAssets.manBackground,
  };

  static Map<Style, Color> traineeColor = {
    Style.STYLE_GOLD: Colors.yellow.shade700,
    Style.STYLE_SILVER: Colors.grey.shade700,
    Style.STYLE_BRONZE: Colors.red.shade700,
    Style.STYLE_FREE: Colors.white,
  };

  static Map<Style, int> styleOrder = {
    Style.STYLE_GOLD: 0,
    Style.STYLE_SILVER: 1,
    Style.STYLE_BRONZE: 2,
    Style.STYLE_FREE: 3,
  };
}
