import 'package:flutter/material.dart';
import 'package:weather_app/pages/citylocationpage.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // hoverColor: Colors.grey,
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 15,
            color: Colors.grey,
          ),
        ),
        title: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: InkWell(
                onTap: () {
                  String userInput = _controller.text;
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CityLocation(userInput: userInput),
                  //   ),
                  // );
                },
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   borderSide: const BorderSide(
                    //     color: Colors.transparent, // Border color
                    //     width: 1.0, // Border width
                    //   ),
                    // ),
                    hintText: 'Search cities',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              )
              // child: const TextField(
              //   decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: 'Search cities',
              //       hintStyle: TextStyle(
              //           color: Colors.grey,
              //           fontWeight: FontWeight.w400,
              //           fontSize: 15,
              //           fontStyle: FontStyle.normal)),
              // ),
              ),
        ),
        actions: const [
          Icon(Icons.search),
=======
        leading: Icon(
          Icons.arrow_back_ios_new,
          size: 15,
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: InkWell(
              onTap: () {},
              child: const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search cities',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontStyle: FontStyle.normal)),
              ),
            ),
          ),
        ),
        actions: const [
          Icon(Icons.search_off),
>>>>>>> e4e7c06414571e11a8a040148c8a17e7802100d9
        ],
      ),
    );
  }
}
