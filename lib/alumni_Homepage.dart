// ignore_for_file: file_names

import 'dart:convert';

import 'package:GLSeUniVerse/alumni_sideNavBar.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/postDiscussion.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:GLSeUniVerse/requestDocs.dart';
import 'package:GLSeUniVerse/securityHomePage.dart';
import 'package:GLSeUniVerse/sideNavigation.dart';
import 'package:GLSeUniVerse/viewDiscussion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:GLSeUniVerse/main.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:http/http.dart' as http;
// import 'dart:ui' as ui;

class alumni_HomePage extends StatefulWidget {
  const alumni_HomePage({super.key});

  @override
  State<alumni_HomePage> createState() => _alumni_HomePageState();
}

class _alumni_HomePageState extends State<alumni_HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primary,
        key: _scaffoldKey,
        drawer: alumni_sideNavBar(),
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
                            child: ImageFromBase64String(base64String: '$finalprofile'),
                            // decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     image: DecorationImage(
                            //         image: NetworkImage(
                            //             "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                            //         fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: (size.width - 40) * 0.6,
                            child: Column(
                              children: [
                                Text(
                                  finalName,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: mainFontColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  finalEnrollment,
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
                                  var headers = {'Content-Type': 'application/json'};
                                  var request = http.Request('GET', Uri.parse('https://poojan16.pythonanywhere.com/api/get_doccategories/'));
                                  request.body = json.encode({
                                    "role": "$finalrole"
                                  });
                                  request.headers.addAll(headers);
                                  // http.StreamedResponse response = await request.send();
                                  final response = await request.send();

                                  if (response.statusCode == 200) {
                                    print("Data Found");

                                    //print(await response.stream.bytesToString());
                                    final data = jsonDecode(await response.stream.bytesToString());
                                    print(data);

                                    docs = data['categories'];//['doc_name'];
                                    items = docs.map((item) => item['doc_name'].toString()).toList();
                                    

                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => requestDocs(),
                                    ));
                                  }
                                  else{
                                    print(response.reasonPhrase);
                                  }
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => requestDocs(),
                                  //     ));
                                  // print("1st Clicked");
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
                                                    "Request Document",
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
                                        builder: (context) => postDiscussion(),
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
                                                    "Post Discussion",
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
                                  print("Clicked 3rd row");
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

