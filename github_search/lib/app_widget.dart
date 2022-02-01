import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/localization/localization_controller.dart';
import 'package:localization/localization.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directory = 'lib/i18n';
    final localizationController = Modular.get<LocalizationController>();

    return MaterialApp(
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }

        // define pt_BR as default when de language code is 'pt'
        if (locale?.languageCode == 'en') {
          return const Locale('en', 'US');
        }

        // default language
        return const Locale('pt', 'BR');
      },
      supportedLocales: localizationController.supportedLocales,
      localizationsDelegates: [
        // delegate from flutter_localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // delegate from localization package.
        LocalJsonLocalization.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    ).modular();
  }
}
