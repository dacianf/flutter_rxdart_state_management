import 'package:flutter/material.dart';
import 'package:rxdart_state_management_article/features/universities_feed/presentation/screen/universities_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UniversitiesScreen(),
      // home: const UniversitiesScreenManualSubscription(),
    );
  }
}
