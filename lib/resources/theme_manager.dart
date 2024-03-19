import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'color_manager.dart';
import 'design_constants.dart';
import 'font_manager.dart';
import 'style_manager.dart';

MaterialColor primarySwatch = const MaterialColor(0xFF00A3E4, {
  50: Color(0xFF00A3E4),
  100: Color(0xFF00A3E4),
  200: Color(0xFF00A3E4),
  300: Color(0xFF00A3E4),
  400: Color(0xFF00A3E4),
  500: Color(0xFF00A3E4),
  600: Color(0xFF00A3E4),
  700: Color(0xFF00A3E4),
  800: Color(0xFF00A3E4),
  900: Color(0xFF00A3E4)
});

ThemeData getLightTheme() {
  return ThemeData(
      colorScheme: ColorScheme(
        primary: ColorManager.primary,
        onPrimary: ColorManager.white,
        secondary: ColorManager.black,
        onSecondary: ColorManager.black,
        surface: ColorManager.white,
        onSurface: ColorManager.black,
        background: ColorManager.white,
        onBackground: ColorManager.black,
        error: Colors.red,
        onError: ColorManager.white,
        brightness: Brightness.light,
        shadow: ColorManager.black.withOpacity(0.36),
      ),
      useMaterial3: true,
      //primaryIconTheme: IconThemeData(color: white),
      //iconTheme: IconThemeData(color: white),
      brightness: Brightness.light,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.white,
      scaffoldBackgroundColor: ColorManager.white14,
      secondaryHeaderColor: ColorManager.white24,
      highlightColor: ColorManager.white14,
      //todo maybe  cause problem
      unselectedWidgetColor: ColorManager.grey,
      //  progressIndicatorTheme: ProgressIndicatorThemeData(color: darkBlue),

      // main colors of the app

      textTheme: TextTheme(
        displayLarge:
            getBoldStyle(color: ColorManager.primary, fontSize: 27.sp),
        displayMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: 22.sp),
        displaySmall:
            getRegularStyle(color: ColorManager.primary, fontSize: 17.sp),
        headlineLarge: getSemiBoldUnderLineStyle(
            color: ColorManager.grey, fontSize: 25.sp),
        headlineMedium:
            getSemiBoldStyle(color: ColorManager.grey, fontSize: 20.sp),
        headlineSmall:
            getMediumStyle(color: ColorManager.grey, fontSize: 15.sp),
        titleLarge: getBoldStyle(color: ColorManager.black, fontSize: 27.sp),
        titleMedium: getMediumStyle(color: ColorManager.black, fontSize: 22.sp),
        titleSmall: getMediumStyle(color: ColorManager.black, fontSize: 17.sp),
        bodyLarge: getBoldStyle(color: ColorManager.white, fontSize: 27.sp),
        bodyMedium: getMediumStyle(color: ColorManager.white, fontSize: 22.sp),
        bodySmall: getRegularStyle(color: ColorManager.white, fontSize: 17.sp),
        labelLarge:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 25.sp),
        labelMedium:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 20.sp),
        labelSmall:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 15.sp),
      ),
      hintColor: ColorManager.black.withOpacity(0.32),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
          elevation: 6,
          minimumSize: Size(24.w, 62.h),
          maximumSize: Size(400.w, 80.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          textStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: FontConstants.fontFamilyJost,
              height: 0.7),
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorManager.black,
        size: 24.w,
        opacity: 1,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: ColorManager.white,
        toolbarHeight: 75.h,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: ColorManager.white,
        foregroundColor: ColorManager.white,
        shadowColor: ColorManager.white,
        titleTextStyle: TextStyle(
            fontFamily: "Hind",
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            height: null,
            color: Colors.white),
        iconTheme: IconThemeData(
          color: ColorManager.white,
          size: 24.w,
          opacity: 1,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: Get.textTheme.bodySmall,
      ),
      dividerTheme: DividerThemeData(
          color: ColorManager.black.withOpacity(0.64),
          thickness: 0.5,
          space: 1),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      ),
      fontFamily: FontConstants.fontFamilyJost,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.white,
        unselectedIconTheme:
            const IconThemeData(color: Colors.black45, size: 20),
        unselectedItemColor: Colors.black45,
        unselectedLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: ColorManager.black),
        selectedIconTheme: IconThemeData(color: ColorManager.black, size: 25),
        selectedItemColor: ColorManager.black,
        selectedLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: ColorManager.black),
        elevation: 20.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      splashColor: Colors.transparent,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(ColorManager.black),
        checkColor: MaterialStateProperty.all<Color>(ColorManager.white),
      ),
      dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(fontSize: 18, color: Colors.red)),
      cardTheme: CardTheme(
          elevation: 15,
          color: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            //set border radius more than 50% of height and width to make circle
          )),
      inputDecorationTheme: InputDecorationTheme(
        border: kOutlinedBorderGray,
        focusedBorder: kOutlinedBorderGray,
        enabledBorder: kOutlinedBorderGray,
        errorBorder: kOutlinedBorderRed,
        // contentPadding: kSmallSymWidth,
      ));
}

getBoxShadow() {
  return [
    BoxShadow(blurRadius: 16, color: ColorManager.black.withOpacity(0.12))
  ];
}

ThemeData getDarkTheme() {
  return ThemeData(
      colorScheme: ColorScheme(
        primary: ColorManager.primary,
        onPrimary: ColorManager.white,
        secondary: ColorManager.black,
        onSecondary: ColorManager.black,
        surface: ColorManager.white,
        onSurface: ColorManager.black,
        background: ColorManager.white,
        onBackground: ColorManager.black,
        error: Colors.red,
        onError: ColorManager.white,
        brightness: Brightness.light,
        shadow: ColorManager.black.withOpacity(0.36),
      ),
      useMaterial3: true,

      //primaryIconTheme: IconThemeData(color: white),
      //iconTheme: IconThemeData(color: white),
      brightness: Brightness.light,
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.black,
      scaffoldBackgroundColor: ColorManager.darkGrey,
      secondaryHeaderColor: ColorManager.white24,
      highlightColor: ColorManager.grey,
      //todo maybe  cause problem
      unselectedWidgetColor: ColorManager.grey,
      //  progressIndicatorTheme: ProgressIndicatorThemeData(color: darkBlue),

      // main colors of the app

      textTheme: TextTheme(
        displayLarge:
            getBoldStyle(color: ColorManager.primary, fontSize: 27.sp),
        displayMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: 22.sp),
        displaySmall:
            getRegularStyle(color: ColorManager.primary, fontSize: 17.sp),
        headlineLarge: getSemiBoldUnderLineStyle(
            color: ColorManager.grey, fontSize: 25.sp),
        headlineMedium:
            getSemiBoldStyle(color: ColorManager.grey, fontSize: 20.sp),
        headlineSmall:
            getMediumStyle(color: ColorManager.grey, fontSize: 15.sp),
        titleLarge: getBoldStyle(color: ColorManager.black, fontSize: 27.sp),
        titleMedium: getMediumStyle(color: ColorManager.black, fontSize: 22.sp),
        titleSmall: getMediumStyle(color: ColorManager.black, fontSize: 17.sp),
        bodyLarge: getBoldStyle(color: ColorManager.white, fontSize: 27.sp),
        bodyMedium: getMediumStyle(color: ColorManager.white, fontSize: 22.sp),
        bodySmall: getRegularStyle(color: ColorManager.white, fontSize: 17.sp),
        labelLarge:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 25.sp),
        labelMedium:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 20.sp),
        labelSmall:
            getMediumStyle(color: ColorManager.darkGrey, fontSize: 15.sp),
      ),
      hintColor: ColorManager.black.withOpacity(0.32),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
          elevation: 6,
          minimumSize: Size(24.w, 62.h),
          maximumSize: Size(400.w, 80.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          textStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              fontFamily: FontConstants.fontFamilyJost,
              height: 0.7),
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorManager.black,
        size: 24.w,
        opacity: 1,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: ColorManager.darkGrey,
        toolbarHeight: 75.h,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: ColorManager.white,
        foregroundColor: ColorManager.darkGrey,
        shadowColor: ColorManager.white,
        titleTextStyle: TextStyle(
            fontFamily: "Hind",
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            height: null,
            color: Colors.white),
        iconTheme: IconThemeData(
          color: ColorManager.white,
          size: 24.w,
          opacity: 1,
        ),
      ),
      dividerTheme: DividerThemeData(
          color: ColorManager.black.withOpacity(0.64),
          thickness: 0.5,
          space: 1),
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      ),
      fontFamily: FontConstants.fontFamilyJost,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.black,
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 20),
        unselectedItemColor: ColorManager.grey,
        unselectedLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: ColorManager.grey),
        selectedIconTheme: IconThemeData(color: ColorManager.primary, size: 25),
        selectedItemColor: ColorManager.primary,
        selectedLabelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: ColorManager.primary),
        elevation: 20.0,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      splashColor: Colors.transparent,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(ColorManager.black),
        checkColor: MaterialStateProperty.all<Color>(ColorManager.white),
      ),
      dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(fontSize: 18, color: Colors.red)),
      cardTheme: CardTheme(
          elevation: 15,
          color: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            //set border radius more than 50% of height and width to make circle
          )),
      inputDecorationTheme: InputDecorationTheme(
        border: kOutlinedBorderWhite,
        focusedBorder: kOutlinedBorderWhite,
        enabledBorder: kOutlinedBorderWhite,
        errorBorder: kOutlinedBorderRed,
        // contentPadding: kSmallSymWidth,
      ));
}
