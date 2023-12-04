import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/api/weatherinfo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {

//   void startApp(BuildContext context) async {
//     try {
//       Position position = await getPosition();
//       WeatherInfo.fetchdata(latitude: position.latitude, longitude: position.longitude);
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       print('Error- $e');
//     }
//   }

 
// Future<Position> getPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 
//   return await Geolocator.getCurrentPosition();
// }
//       // return await Geolocator.getCurrentPosition(
//       //     desiredAccuracy: LocationAccuracy.medium); // unless exact location required low/medium is recommended

  @override
  void initState() {
    super.initState();

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
                    alignment: const AlignmentDirectional(1, -0.1),
                    child: Container(
                      height: size.height * 0.5,
                      width: size.height * 0.45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, -0.1),
                    child: Container(
                      height: size.height * 0.5,
                      width: size.height * 0.45,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: size.height * 0.43,
                      width: size.height * 0.71,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFFFAB40),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 75.0, sigmaY: 75.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Center(
                      child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                          height: size.height * 0.3,
                          width: size.height * 0.3,
                          child: const Image(
                            image: AssetImage('assets/images/logo.png'),
                          )),
                      Text('Weather App',
                          style: GoogleFonts.crimsonText(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30)),
                      SizedBox(
                        height: size.height * 0.245,
                      ),
                      const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                      SpinKitSquareCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),

                          )

                    ],
                  )),
                ],
              ))),
    );
  }
}
