// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:GLSeUniVerse/user_service.dart';

class studentHome extends StatefulWidget {
  const studentHome({super.key});

  @override
  State<studentHome> createState() => _studentHomeState();
}

class _studentHomeState extends State<studentHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? finalName;
  String? finalPicture;
  bool isLoading = true;
  final UserService _userService = UserService();

@override
void initState() {
  super.initState();
  _userService.fetchUserProfile().then((data) {
    if (data != null) {
      setState(() {
        finalName = data['name'];
        finalPicture = data['profile_picture'];
        isLoading = false;
      });
    } else {
      // Handle the case where fetchUserProfile returns null
      setState(() {
        finalName = 'Unknown User'; // Default or placeholder name
        finalPicture = null; // You might set a placeholder image here
        isLoading = false;
      });
      // Optionally, you can show a message to the user
      print('Failed to fetch user profile. Data is null.');
    }
  }).catchError((error) {
    // Handle errors from the fetchUserProfile call
    setState(() {
      isLoading = false;
    });
    print('An error occurred in fetchProfile: $error');
  });
}
 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      key: _scaffoldKey,
      drawer: Drawer(), // Replace with your drawer widget
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.03),
                            spreadRadius: 10,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  icon: Icon(Icons.menu),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: finalPicture != null
                                      ? Image.memory(
                                          base64Decode(finalPicture!),
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: (size.width - 40) * 0.6,
                                  child: Column(
                                    children: [
                                      Text(
                                        finalName ?? 'Name',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Add more user info if needed
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                    // Add other UI components below
                  ],
                ),
        ),
      ),
    );
  }
}
