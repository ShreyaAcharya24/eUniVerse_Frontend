// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:GLSeUniVerse/alumni_home.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/home.dart';
import 'package:GLSeUniVerse/staff_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:GLSeUniVerse/HomePage.dart';
import 'package:GLSeUniVerse/securityHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loadScreen extends StatefulWidget {
  const loadScreen({super.key});

  @override
  State<loadScreen> createState() => _loadScreenState();
}

class _loadScreenState extends State<loadScreen> {
  String role = '';
  String access = '';

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() {
      Timer(const Duration(seconds: 2), () {
        print("\n\n######## In Load: " + access);
        print("\n\n######  In Load: " + role);

        if (role == 'Student') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => access.isEmpty ? loginPage() : home(),
              ));
        } else if (role == 'Alumni') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    access.isEmpty ? loginPage() : alumni_home(),
              ));
        } else if (role == 'Staff') {
          print("Entered in Staff");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    access.isEmpty ? loginPage() : staff_home(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    access.isEmpty ? loginPage() : securityPage(),
              ));
        }
      });
    });
  } // init state

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    access = sharedPreferences.getString('access') ?? '';
    role = sharedPreferences.getString('role') ?? '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPulsingGrid(
          color: mainFontColor,
        ),
      ),
    );
  }
}
