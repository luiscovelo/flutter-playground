import 'package:flutter/material.dart';

class LocalizationController {
  Iterable<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('pt', 'BR'),
  ];

  final languageDefault = ValueNotifier<String>("pt");

  Locale get locale {
    if (languageDefault.value == "en") {
      return const Locale('en', 'US');
    }
    return const Locale('pt', 'BR');
  }
}
