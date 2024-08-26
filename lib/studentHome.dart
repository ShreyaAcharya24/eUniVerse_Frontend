// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access');
    String? role = prefs.getString('role');

    if (token != null && role != null) {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

    var request = http.Request('GET', Uri.parse('https://shreya42.pythonanywhere.com/user-profile/'));
    // Add headers
    request.headers.addAll(headers);

    request.body = json.encode({'role': role});
   
    final response = await request.send();

      if (response.statusCode == 200) {
        final data = jsonDecode(await response.stream.bytesToString());
        setState(() {
          finalName = data['name'];
          finalPicture = data['profile_picture'];
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load profile data');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Handle missing token or role
      print('Token or role is missing');
    }
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
