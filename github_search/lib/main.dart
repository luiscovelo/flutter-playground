import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
