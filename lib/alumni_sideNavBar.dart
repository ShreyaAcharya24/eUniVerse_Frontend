import 'dart:convert';

import 'package:GLSeUniVerse/SplashScreen.dart';
import 'package:GLSeUniVerse/barcodePage.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/editProfile.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:GLSeUniVerse/postDiscussion.dart';
import 'package:GLSeUniVerse/qrPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'users.dart';

class alumni_sideNavBar extends StatelessWidget {
  const alumni_sideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primary,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          accountName: Text(finalName),
          accountEmail: Text(finalEmail),
          currentAccountPicture: CircleAvatar(
            //backgroundImage: NetworkImage(
            //  "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
            child: ImageFromBase64String(base64String: '$finalprofile'),
            radius: 30,
          ),
          decoration: BoxDecoration(
            color: mainFontColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //Container(
        //   child: ListTile(
        //     leading: Icon(
        //       Icons.edit,
        //       size: 30,
        //       color: mainFontColor,
        //     ),
        //     title: Text(
        //       "Edit Profile",
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20,
        //           color: mainFontColor),
        //     ),
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => editProfile(),
        //           ));
        //     },
        //   ),
        
        // // ),
        // SizedBox(
        //   height: 20,
        // ),
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
            // sharedPreferences.remove('email');
            // sharedPreferences.remove('enrollment');
            // sharedPreferences.remove('name');
            // sharedPreferences.remove('div');
            // sharedPreferences.remove('qr_code');
            // sharedPreferences.remove('duration');
            // sharedPreferences.remove('department');
            // sharedPreferences.remove('dept_abbr');
            // sharedPreferences.remove('course_abbr');
            // sharedPreferences.remove('course_name');
            // sharedPreferences.remove('batch_start_year');

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

