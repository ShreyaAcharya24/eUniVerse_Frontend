// ignore_for_file: file_names
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class barcodePage extends StatefulWidget {
  const barcodePage({super.key});

  @override
  State<barcodePage> createState() => _barcodePageState();
}

class _barcodePageState extends State<barcodePage> {
  int myIndex = 2;
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
            margin: EdgeInsets.fromLTRB(0, 200, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //student Name
                Text(
                  finalName,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                // student Email
                Text(finalEmail),
                SizedBox(
                  height: 25,
                ),
                //Barcode
                Image(image: AssetImage('images/barcode.png')),
                SizedBox(
                  height: 25,
                ),
                //student enrollment no
                Text(
                  "MscA2310099001",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
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
                  //batch,division,course
                  child: Center(
                    child: Text(
                        finaldepartment + ' (' + finaldept_abbr + ')',
                        style: TextStyle(color: white)),
                  ),
                ),
                // SizedBox(
                //   height: 35,
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     Get.toNamed('/securityPage');
                //   },
                //   child: Text("Next Page"),
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Color.fromARGB(255, 63, 121, 235)),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
