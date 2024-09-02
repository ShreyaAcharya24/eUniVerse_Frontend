import 'dart:convert';

import 'package:GLSeUniVerse/ErrorPage.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/loader.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:GLSeUniVerse/qr_code_service.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:GLSeUniVerse/visitorEntryPage.dart';
import 'package:GLSeUniVerse/visitorInView.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:GLSeUniVerse/qr_code_service.dart'; // Adjust the path as necessary

class securityPage extends StatefulWidget {
  const securityPage({super.key});

  @override
  State<securityPage> createState() => _securityPageState();
}

class _securityPageState extends State<securityPage> {
// Example of a simple loader dialog
  void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  TextEditingController _enroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
         title: Text(
          "Security Home",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainFontColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 32,
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.clear();
              print('Logged out successfully!');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => loginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),

            Center(
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 15, bottom: 5, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xff67727d)),
                        ),
                        TextField(
                          controller: _enroll,
                          cursorColor: black,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: black),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers_outlined),
                              prefixIconColor: black,
                              hintText: "Search by Username",
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 50,
            ),

// ************** QR Code Scanner ********************
            Container(
              height: 320,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // Navigate to the barcode scanner page and get the scanned string
                              final scannedQRCode = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SimpleBarcodeScannerPage(),
                                ),
                              );

                              // Check if the scanning was successful
                              if (scannedQRCode != null &&
                                  scannedQRCode is String &&
                                  scannedQRCode.isNotEmpty) {
                                print(
                                    "\n\n***** QR scanned **** ${scannedQRCode} ***\n");
                                // Show loader or progress indicator while processing
                                showLoaderDialog(context);

                                // Call the API method with the scanned QR code data
                                final response = await QRCodeService.scanQRCode(
                                    scannedQRCode);

                                // Hide the loader once the API call is completed
                                Navigator.pop(context);

                                // Handle the API response
                                if (response.containsKey('error')) {
                                  // Navigate to the ErrorPage
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ErrorPage(
                                            message: "QR code is not valid"),
                                      ));
                                } else {
                                  // Handle the successful response
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Loader(
                                          responseData:
                                              response), // Navigate to the loader screen
                                    ),
                                  );
                                }
                              } else {
                                // Show a message if the scanning is canceled or failed
                                Fluttertoast.showToast(
                                  msg:
                                      "QR code scanning was canceled or failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.orange,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.03),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.qr_code_2_outlined,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Scan QR Code",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => visitorEntry(),
                                  ));
                              //print("1st Clicked");
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.03),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.bookmark_add_rounded,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Visitor Entry",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => visitorInView(),
                                  ));
                              //print("1st Clicked");
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.03),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.directions_run_rounded,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Visitor In List",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
