import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late String location;
  late String wind;
  late String humidity;
  late String temperature;
  late String weatherType;
  late String weatherDescription;

  void startApp(BuildContext context) async {
    try {
      //Get current position
      Position position = await getPosition();

      //create worker object and fetch weather data
      Worker worker = Worker(city_name: 'pokhara');
          // Worker(latitude: position.latitude, longitude: position.longitude);
      await worker.getdata();

      //set state with weather data retrieved from worker object
      setState(() {
        location = worker.location;
        wind = worker.wind;
        humidity = worker.humidity;
        temperature = worker.temperature;
        weatherDescription = worker.weatherDescription;
        weatherType = worker.weatherType;
      });

      //Navigating to the home page with weather data
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'loc': location,
        'wind': wind,
        'hum': humidity,
        'temp': temperature,
        'weatherDesp': weatherDescription,
        'weather': weatherType,
      });
    } catch (e) {
      print('Error $e');
    }
  }

  Future getPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium); // unless exact location required low/medium is recommended
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    super.initState();
    startApp(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(1, -0.1),
                    child: Container(
                      height: size.height * 0.5,
                      width: size.height * 0.45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, -0.1),
                    child: Container(
                      height: size.height * 0.5,
                      width: size.height * 0.45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: size.height * 0.43,
                      width: size.height*0.71,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFFFAB40),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 75.0, sigmaY: 75.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Center(child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                        height: size.height*0.3,
                        width: size.height*0.3,
                        child: Image(image: AssetImage('assets/images/logo.png'),)),                      
                      Text('Weather App', style: GoogleFonts.crimsonText( color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30)),
                      SizedBox(height: size.height*0.245,),
                      const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ],
                  )),
                ],
              ))),
    );
  }
}
