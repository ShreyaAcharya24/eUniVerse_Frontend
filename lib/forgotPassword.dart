// import 'dart:js';

import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  TextEditingController _email = TextEditingController();

  // function - message for email sent to user
  // void _showMessage(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Email sent!',
  //           style: TextStyle(fontWeight: FontWeight.bold, color: mainFontColor),
  //         ),
  //         content: Text('Please check your mail.'),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pushReplacement(context, MaterialPageRoute(
  //                 builder: (context) {
  //                   return loginPage();
  //                 },
  //               ));
  //             },
  //             child: Text(
  //               'OK',
  //               style: TextStyle(color: white, fontWeight: FontWeight.bold),
  //             ),
  //             style: ElevatedButton.styleFrom(backgroundColor: buttoncolor),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 26),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: mainFontColor),
                      ),
                    )),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text(
                    "Enter your username we will send some details on your email.",
                    style: TextStyle(color: grey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 600,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
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
                            controller: _email,
                            cursorColor: black,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                prefixIconColor: black,
                                hintText: "Enter your Username",
                                border: InputBorder.none),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text(
                      //   "Signup",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w300),
                      // ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return forgotPassword();
                          //   },
                          // ));
                        },
                        child: Text(
                          "Resend Email?",
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: 'Email Sent Successfully!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      fontSize: 16.0);
                    //_showMessage(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    width: 600,
                    decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Send Email",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
