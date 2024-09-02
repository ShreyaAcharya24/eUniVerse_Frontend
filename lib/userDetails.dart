import 'dart:convert';
import 'package:GLSeUniVerse/colors.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> responseData;

  const UserDetails({super.key, required this.responseData});

  @override
  Widget build(BuildContext context) {
    // Determine if the user is a Student, Alumni, or Staff
    bool isStudentOrAlumni =
        responseData.containsKey('batch_s') && responseData.containsKey('batch_e');

    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                // Profile Image
                Container(
                  height: 230,
                  child: Image.memory(
                    base64Decode(responseData['profile_picture']!),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Displaying the full name
                Text(
                  '${responseData['first_name']} ${responseData['last_name']}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Enrollment No (only for Student and Alumni)
                if (isStudentOrAlumni)
                  Text(
                    responseData['enrolment_no'].toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  height: 20,
                ),
                // Display Batch or Joining and Department Name
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
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isStudentOrAlumni
                          ? "Batch: ${responseData['batch_s']} - ${responseData['batch_e']}"
                          : "Department: ${responseData['department_name']}",
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Display Program Name or Joining Date
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
                      ),
                    ],
                  ),
                  child: Text(
                    isStudentOrAlumni
                        ? '${responseData['program_name']}\n${responseData['program_abbr']}'
                        : 'Joining Date: ${responseData['joining']}',
                    style: TextStyle(color: white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Verified Badge and Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified,
                      color: Color.fromARGB(255, 22, 120, 40),
                      size: 35,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Verified',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
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
