import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
    );
  }
}
