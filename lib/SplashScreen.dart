// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:convert';
import 'package:GLSeUniVerse/loadScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'users.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 void initState() {
  print("********Splash Screen*****");
    super.initState();
    Timer(const Duration(seconds: 4), () {
      _checkTokenAndNavigate();
    });
  }

  Future<void> _checkTokenAndNavigate() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access') ?? '';
    print("**********inside token verificiatiom **********");
    if (accessToken.isEmpty || !await _validateToken(accessToken)) {
      print("******Inside IF *********");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginPage(),
          ));
    } else {
       print("******Inside else*********");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loadScreen(),
          ));
    }
  }

  Future<bool> _validateToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://shreya42.pythonanywhere.com/token-verify/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GLS_eUniverse",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset("images/mainQr.json"),
          ],
        ),
      )),
    );
  }
}
