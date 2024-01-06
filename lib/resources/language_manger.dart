import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lang/ar.dart';
import 'lang/en.dart';

class LocalizationService extends Translations {
  static const fallbackLocale = Locale('en', 'UK');

  static final langs = [
    'en',
    'ar',
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'KW'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'ar_AR': ar};

  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    // Get.find<AppController>().lang.value = locale;
    // Get.find<AppController>().setAppLanguage(lang);
    Get.updateLocale(locale);
  }

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale ?? const Locale('ar', 'KW');
  }
}
