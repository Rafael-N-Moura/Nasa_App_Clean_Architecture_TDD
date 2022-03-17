import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app_clean_architecture_tdd/app_module.dart';
import 'package:nasa_app_clean_architecture_tdd/app_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
