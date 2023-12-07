// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weatherinfo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/pages/loadingpage.dart';
import 'package:weather_app/pages/locationpage.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:weather_app/constants/constants.dart';

class CityLocation extends StatefulWidget {
  const CityLocation({super.key});

  @override
  State<CityLocation> createState() => _CityLocationState();
}

class _CityLocationState extends State<CityLocation> {
  WeatherModel? weather;
  String getBackgroundImage(String? weatherType) {
    switch (weatherType) {
      case 'Clear':
        return 'assets/images/few_clouds.jpg';
      case 'Clouds':
        return 'assets/images/overcast_clouds.jpg';
      case 'Rain':
        return 'assets/images/rain.jpg';

      default:
        return 'assets/images/normal.jpg'; // Default image
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: [
            Image.asset(
              getBackgroundImage(weather?.weather.first.main),
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ],
        ),
      )),
    );
  }
}
