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

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? position;
  WeatherModel? weather;

  Future<WeatherModel> getPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    print(position);
    try {
      final weather = await WeatherInfo.fetchdata(
          latitude: position!.latitude, longitude: position!.longitude);
      return weather;
    } catch (e) {
      print('Error- $e');
      throw e;
    }
  }

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
      print('Error $e');
    }
  }

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

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String _convertTimestampToTime(int? timestamp) {
    if (timestamp == null) {
      return 'N/A';
    }
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    return DateFormat.jm().format(dateTime); // Format as time (AM/PM)
  }

  String _getWeatherIcon(String? weatherType) {
    if (weatherType == null) {
      return 'assets/icons/default_icon.png';
    }

    // Map weather type to corresponding icon
    switch (weatherType.toLowerCase()) {
      case 'clear':
        return 'assets/icons/clear-sky.png';
      case 'clouds':
        return 'assets/icons/cloudy.png';
      case 'thunderstorm':
        return 'assets/icons/sunHeavyRain.png';
      case 'rain':
        return 'assets/icons/sunRaint.png';

      default:
        return 'assets/icons/default_icon.png';
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermission(context, Permission.location);
    getPosition();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    Size size = MediaQuery.of(context).size;
    int dayOfWeek = time.weekday;
    String dayName = _getDayOfWeek(dayOfWeek);
    return Scaffold(
      body: FutureBuilder<WeatherModel>(
        future: getPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No weather data available');
          } else {
            WeatherModel weather = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${weather.location ?? 'N/A'}'),
                Text('Temperature: ${weather.temperature ?? 'N/A'}°C'),
                Text(
                    'Sunrise: ${weather.sunrise != null ? _convertTimestampToTime(weather.sunrise) : 'N/A'}'),
                Text(
                    'Sunset: ${weather.sunset != null ? _convertTimestampToTime(weather.sunset) : 'N/A'}'),
                Icon(
                  weather != null
                      ? _getWeatherIcon(weather.weatherType ?? '') as IconData?
                      : Icons.error,
                ),
              ],
            );
          }
        },
      ),

      // body: FutureBuilder<WeatherModel>(
      //   future: getPosition(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {

      //       return Text('Error: ${snapshot.error}');
      //     } else if (!snapshot.hasData || snapshot.data == null) {

      //       return Text('No weather data available');
      //     } else {

      //       WeatherModel weather = snapshot.data!;
      //       return Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text('Location: ${weather.location ?? 'N/A'}'),
      //           Text('Temperature: ${weather.temperature ?? 'N/A'}°C'),

      //           Text('Sunrise: ${weather.sunrise != null ? _convertTimestampToTime(weather.sunrise) : 'N/A'}'),
      //           Text('Sunset: ${weather.sunset != null ? _convertTimestampToTime(weather.sunset) : 'N/A'}'),
      //           Icon(
      //             weather != null
      //                 ? _getWeatherIcon(weather.weatherType ?? '') as IconData?
      //                 : Icons.error,
      //           ),
      //         ],
      //       );
      //     }
      //   },
      // ),
    );
  }
}

//     return FutureBuilder<void>(
//       future: getPosition(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Show a loading indicator while data is being fetched
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           // Handle errors
//           return Text('Error: ${snapshot.error}');
//         } else {
//      Scaffold(
//       body: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text('Location: ${weather?.location ?? 'N/A'}'),
//     Text('Temperature: ${weather?.temperature ?? 'N/A'}°C'),
//     Text('Feels Like: ${weather?.feelsLike ?? 'N/A'}°C'),
//     Text('Min Temperature: ${weather?.tempMin ?? 'N/A'}°C'),
//     Text('Max Temperature: ${weather?.tempMax ?? 'N/A'}°C'),
//     Text('Pressure: ${weather?.pressure ?? 'N/A'} hPa'),
//     Text('Humidity: ${weather?.humidity ?? 'N/A'}%'),
//     Text('Weather Type: ${weather?.weatherType ?? 'N/A'}'),
//     Text('Weather Description: ${weather?.weatherDescription ?? 'N/A'}'),
//     Text('Wind Speed: ${weather?.wind ?? 'N/A'} m/s'),
//     Text('Wind Direction: ${weather?.windDeg ?? 'N/A'}°'),
//     Text('Sunrise: ${weather?.sunrise != null ? _convertTimestampToTime(weather!.sunrise) : 'N/A'}'),
//     Text('Sunset: ${weather?.sunset != null ? _convertTimestampToTime(weather!.sunset) : 'N/A'}'),
//     Icon(
//   weather != null
//       ? _getWeatherIcon(weather?.weatherType ?? '') as IconData?
//       : Icons.error,
// ),
//   ],
// ), ); } }
//     );

//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       //   systemOverlayStyle:
//       //       const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
//       //   leading: mydrawer(onPressed: () => Navigator.push(context,
//       //         MaterialPageRoute(builder: (context) => const HiddenDrawer())), pages: [],)
//       // ),
//       body: SafeArea(
//         child: Container(
//             height: size.height,
//             width: size.width,
//             child: Stack(
//               children: [
//                 Image.asset(
//                   getBackgroundImage(weather?.weatherType),
//                   height: size.height,
//                   width: size.width,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(color: Colors.black.withOpacity(0.4),),
//                 Column(
//                   children: [
//                     // Container
//                     // (
//                     //   height: size.height*0.1,
//                     //   width: size.width*0.8,
//                     //   child: mydrawer(onPressed: () => Navigator.push(context,
//                     //          MaterialPageRoute(builder: (context) => const HiddenDrawer())), pages: pages,),
//                     // ),
//                     // SizedBox(height: 20),
//                     Flexible(
//                       flex: 6,
//                       child: Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                                 padding: EdgeInsets.fromLTRB(15, 22, 15, 15),
//                                 child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Expanded(
//                                         flex: 1,
//                                         child: SizedBox(
//                                           child:
//                                               Text('${time.hour}:${time.minute}',
//                                                   style: GoogleFonts.crimsonText(
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.w500,
//                                                   )),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 2,
//                                         child: SizedBox(
//                                           child: Text(weather?.location ?? 'Bharatpur',
//                                               style: GoogleFonts.lato(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w300,
//                                                 fontSize: 40,
//                                               )),
//                                         ),
//                                       ),
//                                       Container(
//                                         color: Colors.white,
//                                         height: 0.5,
//                                         width: 180,
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Expanded(
//                                         flex: 1,
//                                         child: SizedBox(
//                                           child: Row(
//                                             children: [
//                                               Text(dayName,
//                                                   style: GoogleFonts.lato(
//                                                       color: Colors.white,
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.w300)),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Text(
//                                                   '${time.month}.${time.day}.${time.year}',
//                                                   style: GoogleFonts.crimsonText(
//                                                       color: Colors.white,
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.w300)),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Container(
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 weather?.temperature ?? '33',
//                                                 style: GoogleFonts.crimsonText(
//                                                     color: Colors.white,
//                                                     fontSize: 70,
//                                                     fontWeight: FontWeight.w600),
//                                               ),
//                                               const SizedBox(
//                                                 width: 35,
//                                               ),
//                                               Text(
//                                                 weather?.weatherType ?? 'Clear',
//                                                 style: GoogleFonts.lato(
//                                                     color: Colors.white,
//                                                     fontSize: 22,
//                                                     fontWeight:
//                                                         FontWeight.normal),
//                                               ),

//                                               //
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 7,
//                                         child: Container(
//                                           child: Text(
//                                             weather?.weatherDescription ?? '',
//                                             style: GoogleFonts.lato(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w300,
//                                               fontSize: 45,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ])),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 20),
//                               child: Column(
//                                 children: [
//                                   const Row(
//                                     children: [
//                                       CircleAvatar(
//                                           radius: 15,
//                                           backgroundColor:
//                                               Color.fromARGB(255, 253, 229, 228),
//                                           child: IconButton(
//                                             onPressed: null,
//                                             icon: Icon(
//                                               Icons.settings,
//                                               size: 15,
//                                             ),
//                                           )),
//                                       CircleAvatar(
//                                           radius: 15,
//                                           backgroundColor: Colors.white,
//                                           child: IconButton(
//                                               onPressed: null,
//                                               icon: Icon(
//                                                 Icons.home_outlined,
//                                                 size: 15,
//                                                 color: Colors.black,
//                                               )))
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 60,
//                                   ),
//                                   Container(
//                                     height: 20,
//                                     padding:
//                                         const EdgeInsets.fromLTRB(8, 2, 8, 2),
//                                     decoration: const BoxDecoration(
//                                       color: Color.fromARGB(255, 242, 191, 187),
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                     ),
//                                     child: Text('Wind',
//                                         textAlign: TextAlign.end,
//                                         style: GoogleFonts.lato(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500)),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Text(
//                                     '3.4 km/h',
//                                     textAlign: TextAlign.end,
//                                     style: GoogleFonts.crimsonText(
//                                         color: Colors.white,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w100),
//                                   ),
//                                   const SizedBox(
//                                     height: 17,
//                                   ),
//                                   UnconstrainedBox(
//                                     child: Container(
//                                       height: 20,
//                                       padding:
//                                           const EdgeInsets.fromLTRB(8, 2, 8, 2),
//                                       decoration: const BoxDecoration(
//                                         color: Color.fromARGB(255, 242, 191, 187),
//                                         borderRadius:
//                                             BorderRadius.all(Radius.circular(15)),
//                                       ),
//                                       child: Text('Humidity',
//                                           textAlign: TextAlign.end,
//                                           style: GoogleFonts.lato(
//                                               color: Colors.white,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500)),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Text(
//                                     '78%',
//                                     textAlign: TextAlign.end,
//                                     style: GoogleFonts.crimsonText(
//                                         color: Colors.white,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w100),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 2,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 10),
//                         child: Column(
//                           children: [
//                             divider(),

//                             divider(),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 3,
//                       child: Container(
//                         width: double.infinity,
//                         margin: const EdgeInsets.all(17),
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(40)),
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/map.jpg'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: 130,
//                                   margin:
//                                       const EdgeInsets.fromLTRB(25, 25, 0, 25),
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(40)),
//                                     color: Colors.white,
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 18.0, vertical: 9.0),
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           hintText: 'add location',
//                                           hintStyle: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 18,
//                                               fontStyle: FontStyle.italic)),
//                                     ),
//                                   ),
//                                 ),
//                                 const CircleAvatar(
//                                   radius: 20.0,
//                                   child: Icon(
//                                     CupertinoIcons.location_solid,
//                                     color: Colors.black,
//                                     size: 22.0,
//                                   ),
//                                   backgroundColor: Colors.white,
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(25, 35, 25, 25),
//                               child: Container(
//                                 width: 70.0,
//                                 height: 70.0,
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: const Color.fromARGB(
//                                           255, 220, 217, 217),
//                                       width: 2.0,
//                                       style: BorderStyle.solid,
//                                     )),
//                                 child: const CircleAvatar(
//                                   radius: 30,
//                                   backgroundImage:
//                                       AssetImage('assets/images/logoimage.jpg'),
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             )),
//       ),
//     );

// class divider extends StatelessWidget {
//   const divider({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const Divider(
//       color: Colors.white,
//       indent: 20,
//       endIndent: 20,
//       thickness: 1.0,
//       height: 0.5,
//     );
//   }
