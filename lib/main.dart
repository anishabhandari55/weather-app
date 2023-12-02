import 'package:flutter/material.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/loadingpage.dart';
import 'package:weather_app/pages/test.dart';
// import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => const TestScreen(),
        // '/home': (context) => const HomePage(),
      },
    );
  }
}
