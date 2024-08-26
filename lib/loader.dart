import 'dart:async';

import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loader extends StatefulWidget {
  const loader({super.key});

  @override
  State<loader> createState() => _loaderState();
}

class _loaderState extends State<loader> {

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {

      print("loaderclass");

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => userDetails()));
          
    });
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