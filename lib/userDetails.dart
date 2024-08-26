import 'dart:convert';

import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/securityHomePage.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';

class userDetails extends StatefulWidget {
  const userDetails({super.key});

  @override
  State<userDetails> createState() => _userDetailsState();
}

class _userDetailsState extends State<userDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //student Image
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: ImageFromBase64String(base64String: '$finalqr_profile'),
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
                // student Name
                Text(
                  finalqr_name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Enrollment no of student
                // Text(
                //   finalEnrollment,
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // // student Email
                // Text(
                //   finalEmail,
                //   style: TextStyle(fontSize: 15, color: Colors.grey),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 350,
                  decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      child:
                          //Department
                          Text(
                    'Department Name: '+finalqr_department,
                    style: TextStyle(color: white),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 350,
                  decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      //batch,course
                      child: Text(
                    "Course Name: " + finalqr_program,
                    style: TextStyle(color: white),
                  )),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 350,
                  decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.03),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Center(
                      //batch,course
                      child: Text(
                    "Role : " + finalqr_role,
                    style: TextStyle(color: white),
                  )),
                ),
                
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get.toNamed('/barcodePage');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => securityPage(),
                        ));
                  },
                  child: Text(
                    'Approved',
                    style: TextStyle(
                        fontSize: 20,
                        color: buttoncolor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

