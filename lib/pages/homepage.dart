import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/weatherinfo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/hidden_drawer.dart';
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

  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    print(position);
    try {
      final weather = await WeatherInfo.fetchdata(
          latitude: position!.latitude, longitude: position!.longitude);
      print(weather.weatherDescription);
      setState(() {
        this.weather = weather;
        print(this.weather!.location);
      });
    } catch (e) {
      print('Error- $e');
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

  @override
  void initState() {
    super.initState();
    checkPermission(context, Permission.location);
    getPosition();
  }

  // final List<Map<String, dynamic>> gridData = [
  //   {'icon': Icons.home, 'text': 'Home'},
  //   {'icon': Icons.work, 'text': 'Work'},
  //   {'icon': Icons.school, 'text': 'School'},
  //   {'icon': Icons.favorite, 'text': 'Favorite'},
  //   {'icon': Icons.music_note, 'text': 'Music'},
  //   {'icon': Icons.shopping_cart, 'text': 'Shopping'},
  // ];

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    Size size = MediaQuery.of(context).size;
    int dayOfWeek = time.weekday;
    String dayName = _getDayOfWeek(dayOfWeek);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Image.asset(
                  getBackgroundImage(weather?.weatherType),
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(15, 22, 15, 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(height: 5),
                                      SizedBox(
                                        child:
                                            Text('${time.hour}:${time.minute}',
                                                style: GoogleFonts.crimsonText(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        child: Text(
                                            weather?.location ?? 'Bharatpur',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 50,
                                            )),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 0.5,
                                        width: 220,
                                      ),
                                      SizedBox(height: 5),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Text(dayName,
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                '${time.month}.${time.day}.${time.year}',
                                                style: GoogleFonts.crimsonText(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              '26\u00B0',
                                              style: GoogleFonts.crimsonText(
                                                  color: Colors.white,
                                                  fontSize: 70,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              'Clear',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w300),
                                            ),

                                            //
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 25),

                                      // Container(
                                      //   color: Colors.white,
                                      //   height: 0.5,
                                      //   width: 300,
                                      // ),
                                    ])),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 229, 228),
                                          // child: GestureDetector(
                                          // onTap: () {
                                          //   Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               LocationPage()));
                                          // },
                                          //   child: Icon(
                                          //     Icons.location_on,
                                          //     size: 15,
                                          //   ),
                                          // ),

                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LocationPage()));
                                              },
                                              hoverColor: Colors.grey,
                                              focusColor: Colors.white,
                                              icon: Icon(
                                                Icons.location_on,
                                                size: 15,
                                              ))),
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                Icons.home_outlined,
                                                size: 15,
                                                color: Colors.black,
                                              )))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Container(
                                    height: 25,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 242, 191, 187),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text('Wind',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '3.4 km/h',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.crimsonText(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  UnconstrainedBox(
                                    child: Container(
                                      height: 25,
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 242, 191, 187),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Text('Humidity',
                                          textAlign: TextAlign.end,
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '78%',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.crimsonText(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      // kbhbhvgbjnjn
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 5, 60, 5),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            divider(),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Thursday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 75),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "11\u00B0  21\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Friday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 96),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "11\u00B0  22\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Saturday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 79),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "11\u00B0  21\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Sunday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 90),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "10\u00B0  19\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Monday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 87),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "11\u00B0  20\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Tuesday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 84),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "11\u00B0  22\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  "Wednesday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(width: 65),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.yellow,
                                    )),
                                SizedBox(width: 75),
                                Text(
                                  "8\u00B0  23\u00B0",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 80),
                            //     Text(
                            //       "Thursday",
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w300),
                            //     ),
                            //     SizedBox(width: 43),
                            //     IconButton(
                            //         onPressed: null,
                            //         icon: Icon(
                            //           Icons.sunny,
                            //           size: 20,
                            //           color: Colors.yellow,
                            //         )),
                            //     SizedBox(width: 40),
                            //     Text(
                            //       "9\u00B0  25\u00B0",
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w300),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 80),
                            //     Text(
                            //       "Friday",
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w300),
                            //     ),
                            //     SizedBox(width: 66),
                            //     IconButton(
                            //         onPressed: null,
                            //         icon: Icon(
                            //           Icons.sunny,
                            //           size: 20,
                            //           color: Colors.yellow,
                            //         )),
                            //     SizedBox(width: 40),
                            //     Text(
                            //       "10\u00B0  27\u00B0",
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w300),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 5),
                            divider(),
                            SizedBox(height: 25),
                            Column(
                              children: [],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class divider extends StatelessWidget {
  const divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      indent: 20,
      endIndent: 20,
      thickness: 0.5,
      height: 0.5,
    );
  }
}

String getBackgroundImage(String? weatherType) {
  switch (weatherType) {
    case 'Clear':
      return 'assets/images/clear_sky.jpg';
    case 'Clouds':
      return 'assets/images/cloudy.jpg';
    // Add more cases for other weather types...

    default:
      return 'assets/images/default_background.jpg'; // Default image
  }
}

class mydrawer extends StatelessWidget {
  const mydrawer({
    super.key,
    required this.pages,
    required onPressed,
  });

  final List<ScreenHiddenDrawer> pages;

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.deepOrange.shade300,
      screens: pages, // list of pages
      initPositionSelected: 0,
      slidePercent: 60,
    );
  }
}
