// ignore_for_file: file_names
import 'dart:convert';
import 'package:GLSeUniVerse/side_navbar.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/user_service.dart';
import 'package:GLSeUniVerse/requestDocs.dart';
import 'package:flutter/material.dart';

class staff_Homepage extends StatefulWidget {
  const staff_Homepage({super.key});

  @override
  State<staff_Homepage> createState() => _staff_HomepageState();
}

class _staff_HomepageState extends State<staff_Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? finalName;
  String? finalPicture;
  String? finalEmail;
  String? finalDep;
  bool isLoading = true;
  final UserService _userService = UserService();

@override
void initState() {
  super.initState();
  _loadUserProfile();
}
void _loadUserProfile() async {
    try {
      final data = await _userService.fetchUserProfile();
      if (data != null) {
        setState(() {
          finalName = data['name'];
          finalPicture = data['profile_picture'];
          finalEmail = data['email'];
          finalDep = data['program'];
          isLoading = false;
        });
      } else {
        setState(() {
          finalName = 'Unknown User'; // Default or placeholder name
          finalPicture = null;
          finalEmail = null;
          finalDep = null; // You might set a placeholder image here
          isLoading = false;
        });
        print('*******Failed to fetch user profile. Data is null.');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('An error occurred in fetchProfile: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primary,
        key: _scaffoldKey,
        drawer: finalName != null && finalPicture != null
            ? side_navbar(
                finalName: finalName!,
                finalPicture: finalPicture!,
                finalEmail: finalEmail!,
                )
            : null,
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
                        spreadRadius: 8,
                        blurRadius: 2,
                        // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 0, right: 10, left: 10),
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
                          isLoading ? Center(child: CircularProgressIndicator()):
                          Container(
                            width: 180,
                            height: 180,
                            child: finalPicture != null
                                      ? Image.memory(
                                          base64Decode(finalPicture!),
                                          fit: BoxFit.cover,
                                        ):Container(),
                            
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: (size.width - 40) * 0.6,
                            child: Column(
                              children: [
                                Text(
                                  finalName ?? '',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  finalDep ?? '',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  finalEmail ?? '',
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
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => requestDocs(),
                                  ));
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
                                        builder: (context) => requestDocs(),
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
