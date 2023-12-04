import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/api/weatherinfo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
   Position? position;
   WeatherModel? weather;
  
  Future<void> getPosition() async {
    position =  await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
    print(position);
    try{
      print(position!.latitude);
      print(position!.longitude);
    final weather = await WeatherInfo.fetchdata(latitude: position!.latitude, longitude: position!.longitude); 
    }catch(e){
      print(e);
    }
      setState(() {
        // print(weather.location);
      });

  }
  @override
  void initState() {
    getPosition();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/few_clouds.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.darken,

                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //   Color.fromARGB(255, 249, 113, 104),
                    //   Color.fromARGB(255, 193, 145, 136),
                    // ])
                  ),
                ),
                // Container(color: Colors.black.withOpacity(0.3),),
                Column(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
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
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: Text('${time.hour}:${time.minute}',
                                              style: GoogleFonts.crimsonText(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          child: Text(weather?.location??'',
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 40,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white,
                                        height: 0.5,
                                        width: 180,
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          child: Row(
                                            children: [
                                              Text('Today',
                                                  style: GoogleFonts.lato(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text('${time.month}.${time.day}.${time.year}',
                                                  style:
                                                      GoogleFonts.crimsonText(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                '26\u00B0',
                                                style: GoogleFonts.crimsonText(
                                                    color: Colors.white,
                                                    fontSize: 70,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                              Text(
                                                'Clear',
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),

                                              //
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          child: Text(
                                            "It's\nSunny\nOut\n",
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 45,
                                            ),
                                          ),
                                        ),
                                      )
                                    ])),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 229, 228),
                                          child: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.settings,
                                              size: 15,
                                            ),
                                          )),
                                      CircleAvatar(
                                          radius: 15,
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
                                    height: 20,
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
                                            fontSize: 12,
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
                                      height: 20,
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
                                              fontSize: 12,
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
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Column(
                          children: [
                            divider(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '10\u00B0',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Today',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text('10\u00B0',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            'Clear',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            divider(),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(17),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          image: DecorationImage(
                                  image: AssetImage('assets/images/map.jpg'),
                                  fit: BoxFit.cover,
                                ),
                         ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 130,
                                  margin: const EdgeInsets.fromLTRB(25, 25, 0, 25),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40)),
                                    color: Colors.white,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 9.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'add location',
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic)),
                                    ),
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    CupertinoIcons.location_solid,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  backgroundColor: Colors.white,
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 35, 25, 25),
                              child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 220, 217, 217),
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                    )),
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/logoimage.jpg'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
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
      thickness: 1.0,
      height: 0.5,
    );
  }
}
