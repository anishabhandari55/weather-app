import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/pages/locationpage.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Homepage',
            baseStyle: kTextStyle,
            selectedStyle: kTextStyle,
            colorLineSelected: Colors.deepOrange,
          ),
          HomePage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Locationpage',
            baseStyle: kTextStyle,
            selectedStyle: kTextStyle,
            colorLineSelected: Colors.deepOrange
          ),
          LocationPage()),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mydrawer(pages: pages);
  }
}

class mydrawer extends StatelessWidget {
  const mydrawer({
    super.key,
    required this.pages,
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
