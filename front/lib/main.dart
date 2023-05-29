import 'package:flutter/material.dart';
import 'package:flat/screens/home_screen.dart';
import 'package:flat/screens/speech_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/speech': (context) => SpeechScreen(),
      },
    );
  }
}
