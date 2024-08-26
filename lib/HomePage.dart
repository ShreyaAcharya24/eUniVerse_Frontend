// ignore_for_file: file_names

import 'dart:convert';

import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:GLSeUniVerse/requestDocs.dart';
import 'package:GLSeUniVerse/securityHomePage.dart';
import 'package:GLSeUniVerse/sideNavigation.dart';
import 'package:GLSeUniVerse/viewDiscussion.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:GLSeUniVerse/main.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String profileImage = '';
  String userName = '';
  String program='';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access');
    String? role = prefs.getString('role');
    try {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json' // Add your JWT token here
      };

      var request = http.Request(
          'GET',
          Uri.parse(
              'https://shreya42.pythonanywhere.com/user-profile/?role=$role'));
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final data = jsonDecode(await response.stream.bytesToString());
        setState(() {
          profileImage = data['profile_picture'];
          userName = data['name'];
          program =data['program'];
        });
      } else {
        print('Failed to load profile data');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primary,
        key: _scaffoldKey,
        drawer: sideNavigation(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
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
                      top: 20, bottom: 0, right: 20, left: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            child: profileImage.isNotEmpty
                                ? ImageFromBase64String(
                                    base64String: profileImage)
                                : CircularProgressIndicator(), // Placeholder
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: (size.width - 40) * 0.6,
                            child: Column(
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  program,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Overview",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: mainFontColor,
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 320,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  print(finalrole);
                                  var headers = {
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'GET',
                                      Uri.parse(
                                          'https://poojan16.pythonanywhere.com/api/get_doccategories/'));
                                  request.body =
                                      json.encode({"role": "$finalrole"});
                                  request.headers.addAll(headers);
                                  // http.StreamedResponse response = await request.send();
                                  final response = await request.send();

                                  if (response.statusCode == 200) {
                                    print("Data Found");

                                    //print(await response.stream.bytesToString());
                                    final data = jsonDecode(
                                        await response.stream.bytesToString());
                                    print(data);

                                    docs = data['categories']; //['doc_name'];
                                    items = docs
                                        .map((item) =>
                                            item['doc_name'].toString())
                                        .toList();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => requestDocs(),
                                        ));
                                  } else {
                                    print(response.reasonPhrase);
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => requestDocs(),
                                  //     ));
                                  print("1st Clicked");
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
                                        top: 10,
                                        bottom: 10,
                                        right: 20,
                                        left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: arrowbgColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                              child: Icon(
                                            Icons.feed_outlined,
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
                                                    "Request Documents",
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
                                        builder: (context) => viewDiscussion(),
                                      ));
                                  print("Clicked!!");
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
                                        top: 10,
                                        bottom: 10,
                                        right: 20,
                                        left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: arrowbgColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // shape: BoxShape.circle
                                          ),
                                          child: Center(
                                              child: Icon(
                                            Icons.feed_outlined,
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
                                                    "View Discussion",
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
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

class ImageFromBase64String extends StatelessWidget {
  final String base64String;
  const ImageFromBase64String({Key? key, required this.base64String})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
      ),
    );
  }
}
