import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rxdart_state_management_article/app.dart';
import 'package:rxdart_state_management_article/utils/app_config.dart';

void main() {
  _setupLogging();
  AppConfig.setEnvironment(Environment.dev);
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
