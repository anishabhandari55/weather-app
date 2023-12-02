import 'package:flutter/material.dart';
import 'package:weather_app/api/weather.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();

    Weather.fetch(latitude: 4.324, longitude: 34.43);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Test Screen'),
      ),
    );
  }
}
