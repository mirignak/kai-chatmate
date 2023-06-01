import 'package:flat/screens/report_screen.dart';
import 'package:flat/screens/home_screen.dart';
import 'package:flat/screens/settings_screen.dart';
import 'package:flat/screens/speech_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English chat with GPT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/speech': (context) => SpeechScreen(),
        '/report': (context) => ReportScreen(),
      },
    );
  }
}
