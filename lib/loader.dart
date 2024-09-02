import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/userDetails.dart';

class Loader extends StatelessWidget {
  final Map<String, dynamic> responseData;

  const Loader({super.key, required this.responseData});

  @override
  Widget build(BuildContext context) {
    // Delayed navigation to simulate the timer functionality from the StatefulWidget
    Future.delayed(const Duration(seconds: 1), () {
      print("\n\n ***** Inside Loader class $responseData ****** "); // Direct access to responseData
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetails(responseData: responseData), // Passing responseData to userDetails
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: SpinKitPulsingGrid(
          color: mainFontColor,
        ),
      ),
    );
  }
}
