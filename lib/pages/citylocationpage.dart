// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/models/weather_model.dart';

// class CityLocation extends StatefulWidget {
//   const CityLocation({ super.key});

//   @override
//   State<CityLocation> createState() => _CityLocationState();
// }

// class _CityLocationState extends State<CityLocation> {
//   WeatherModel? weather;
//   final String userInput;

//   const NextPage({required this.userInput});

//   @override
  
//   String getBackgroundImage(String? weatherType) {
//     switch (weatherType) {
//       case 'Clear':
//         return 'assets/images/few_clouds.jpg';
//       case 'Clouds':
//         return 'assets/images/overcast_clouds.jpg';
//       case 'Rain':
//         return 'assets/images/rain.jpg';

//       default:
//         return 'assets/images/normal.jpg'; // Default image
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         child: Stack(
//           children: [
//             Image.asset(
//               getBackgroundImage(weather?.weatherType),
//               height: size.height,
//               width: size.width,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               color: Colors.black.withOpacity(0.4),
//             ),
            
//           ],
//         ),
//       )),
//     );
//   }
// }
