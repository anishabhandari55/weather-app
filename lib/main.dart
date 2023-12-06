import 'package:flutter/material.dart';
import 'package:weather_app/hidden_drawer.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/loadingpage.dart';
import 'package:weather_app/pages/locationpage.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      title: 'Weather App',
      //  home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/home': (context) =>  HomePage(),
        '/addlocation': (context) => LocationPage(),
      },
    );
  }
}
