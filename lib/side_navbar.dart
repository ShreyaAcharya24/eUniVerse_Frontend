import 'dart:convert';

import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:GLSeUniVerse/postDiscussion.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class side_navbar extends StatelessWidget {
  final String finalName;
  final String finalPicture;
  final String finalEmail;
  

  const side_navbar({
    super.key,
    required this.finalName,
    required this.finalPicture,
    required this.finalEmail,
    });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primary,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          accountName: Text(finalName),
          accountEmail: Text(finalEmail),
          currentAccountPicture: CircleAvatar(
          radius: 30,
          backgroundImage: MemoryImage(base64Decode(finalPicture)),
          backgroundColor: Colors.transparent, // Optional: Set this to transparent to ensure the circle shape is clean
  ),
          decoration: BoxDecoration(
            color: mainFontColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.qr_code_2_outlined,
            size: 30,
            color: mainFontColor,
          ),
          title: Text(
            "Qr-Code",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: mainFontColor),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return qrPage();
              },
            ));
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.announcement,
            size: 30,
            color: mainFontColor,
          ),
          title: Text(
            "Discussions",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: mainFontColor),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return postDiscussion();
              },
            ));
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            CupertinoIcons.barcode,
            size: 30,
            color: mainFontColor,
          ),
          title: Text(
            "Barcode",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: mainFontColor),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return barcodePage();
              },
            ));
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            size: 30,
            color: mainFontColor,
          ),
          title: Text(
            "Logout",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: mainFontColor),
          ),
          onTap: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            
            await sharedPreferences.clear();
            print('okay!');

            Fluttertoast.showToast(
              msg: "Logged Out Successfully!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0
            );
      

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return loginPage();
              },
            ));
          },
        ),
      ]),
    );
  }
}



