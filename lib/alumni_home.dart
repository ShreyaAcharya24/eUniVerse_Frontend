// ignore_for_file: file_names
import 'package:GLSeUniVerse/alumni_Homepage.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
// import 'dart:ui' as ui;

class alumni_home extends StatefulWidget {
  const alumni_home({super.key});

  @override
  State<alumni_home> createState() => _alumni_homeState();
}

class _alumni_homeState extends State<alumni_home> {
  int pageIndex = 1;

  List<Widget> pages = [
    qrPage(),
    alumni_HomePage(),
    barcodePage(),
  ];

  @override
  void initState() {
    super.initState();
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void dispose() {
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);

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
