import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/pages/homepage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  //const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<void> checkPermission(
      BuildContext context, Permission permission) async {
    try {
      final status = await permission.request();
      print(status);
      if (status.isGranted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission granted')));
        setState(() {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission denied')));
      }
    } catch (e) {
      print('Error- $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission(context, Permission.location);
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
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
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
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
                        // controller: AnimationController(vsync: this, duration: const Duration(seconds: 1200)),
                      )
                    ],
                  )),
                ],
              ))),
    );
  }
}
