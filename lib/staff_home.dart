// ignore_for_file: file_names
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:GLSeUniVerse/staff_Homepage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
// import 'dart:ui' as ui;

class staff_home extends StatefulWidget {
  const staff_home({super.key});

  @override
  State<staff_home> createState() => _staff_homeState();
}

class _staff_homeState extends State<staff_home> {
  int pageIndex = 1;

  List<Widget> pages = [
    qrPage(),
    staff_Homepage(),
    barcodePage(),
  ];

  @override
  void initState(){
    super.initState();
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
  @override
  void dispose(){
    FlutterWindowManager.clearFlags(
      FlutterWindowManager.FLAG_SECURE
    );

    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.qrcode,
      CupertinoIcons.home,
      CupertinoIcons.barcode,
    ];
    return AnimatedBottomNavigationBar(
        backgroundColor: primary,
        icons: iconItems,
        splashColor: secondary,
        inactiveColor: black.withOpacity(0.5),
        gapLocation: GapLocation.none,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        iconSize: 30,
        rightCornerRadius: 10,
        elevation: 2,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
