// regular style

import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color,
    {TextDecoration? textDecoration}) {
  return TextStyle(
      decoration: textDecoration,
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular style

TextStyle? getRegularStyle({required Color color, double? fontSize}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontConstants.fontFamilyJost,
      FontWeightManager.regular, color);
}

// medium text style

TextStyle? getMediumStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? FontSize.s12, FontConstants.fontFamilyJost,
      FontWeightManager.medium, color);
}
// medium text style

TextStyle? getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? FontSize.s14, FontConstants.fontFamilyJost,
      FontWeightManager.bold, color);
}

TextStyle? getSemiBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? FontSize.s14, FontConstants.fontFamilyJost,
      FontWeightManager.semiBold, color);
}

TextStyle? getSemiBoldUnderLineStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize ?? FontSize.s14, FontConstants.fontFamilyJost,
      FontWeightManager.semiBold, color,textDecoration: TextDecoration.underline);
}
