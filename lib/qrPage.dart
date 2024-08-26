// ignore_for_file: file_names

// import 'package:GLSeUniVerse/SplashScreen.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class qrPage extends StatefulWidget {
  const qrPage({super.key});

  @override
  State<qrPage> createState() => _qrPageState();
}

class _qrPageState extends State<qrPage> {
  int myIndex = 0;
  //String qr = users.qr_code;
  @override
  void initState(){
    super.initState();
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
  @override
  void dispose(){
    FlutterWindowManager.clearFlags(
      FlutterWindowManager.FLAG_SECURE
    );

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: CupertinoColors.activeBlue,
      //   onTap: (index) {
      //     setState(() {
      //       myIndex = index;
      //     });

      //     if (index == 0) {
      //       Get.toNamed('/qrPage');
      //     } else if (index == 1) {
      //       Get.toNamed('/studentHomePage');
      //     } else if (index == 2) {
      //       Get.toNamed('/barcodePage');
      //     }
      //   },
      //   currentIndex: myIndex,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'QR Code'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.bar_chart_sharp), label: 'Barcode'),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //student Image
                CircleAvatar(
                  radius: 50,
                  //backgroundImage: AssetImage('images/profile.png'),
                  //backgroundImage: NetworkImage(
                     // "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),

                  child: ImageFromBase64String(base64String: '$finalprofile'),
                ),
                //ImageFromBase64String(base64String: users.qr_code),
                SizedBox(
                  height: 10,
                ),
                // student Name
                Text(
                  //users.name,
                  '$finalName',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Qr Code
                // Image(
                //   child: ImageFromBase64String(base64String: users.qr_code),
                //   height: 250,
                // ),

                Container(
                  //child:ImageFromBase64String(base64String: ''),
                  child: ImageFromBase64String(base64String: '$finalqr_code'),
                  height: 250,
                ),
                SizedBox(
                  height: 10,
                ),
                // Enrollment no of student
                Text(
                  //users.enrollment,
                  '$finalEnrollment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                // student Email
                Text(
                  '$finalEmail',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
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
                      child:
                          //Department
                          Text(
                              //users.department +' - '+ users.dept_abbr,
                              '$finaldepartment' + ' - ' + '$finaldept_abbr',
                              style: TextStyle(color: white))),
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
                  child: Text(
                    //users.course_name +'\nBatch: '+ users.batch_start_year ,
                    '$finalcourse_name' +
                        '\nBatch: ' +
                        '$finalbatch_start_year',
                    style: TextStyle(color: white),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.toNamed('/barcodePage');
                //     },
                //     child: Text('Barcode Page'))
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
