// ignore_for_file: file_names

// import 'package:GLSeUniVerse/SplashScreen.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class qrPage extends StatefulWidget {
  const qrPage({super.key});

  @override
  State<qrPage> createState() => _qrPageState();
}

class _qrPageState extends State<qrPage> {
  int myIndex = 0;
  //String qr = users.qr_code;
  String? qrCodeBase64;
  String? id;
  String? user_role;
  String? name;
  @override
  void initState(){
    super.initState();
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    _getQR();
  }
  @override
  void dispose(){
    FlutterWindowManager.clearFlags(
      FlutterWindowManager.FLAG_SECURE
    );

    super.dispose();
  }

  Future<void> _getQR() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access');
    String? role = prefs.getString('role');

    if (accessToken != null && role != null) {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
      
      var request = http.Request('POST',Uri.parse('https://shreya42.pythonanywhere.com/generate-qr/'));
      request.headers.addAll(headers);
      request.body = json.encode({'role': role});

      try {
        final response = await request.send();
        final responseData = jsonDecode(await response.stream.bytesToString());
        if (response.statusCode == 200) {
          // Handle the successful response here
            qrCodeBase64 = responseData['qr_code'];
            id = responseData['id'];
            user_role = responseData['role'];
            name = responseData['name'];
           setState(() {
          });
          print('API Response: $responseData');
        } else {
          // Handle the error here
          print('Failed to call API: ${response.statusCode}');
        }
      } catch (e) {
        print('Error calling API: $e');
      }
    } else {
      // Handle the case where the token or role is missing
      print('Access token or role is missing');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR Page",
          style: TextStyle(color: white),
        ),
        backgroundColor: mainFontColor,
      ),
      backgroundColor: arrowbgColor,
      // backgroundColor: primary,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox( 
                  height: 10,
                ),
                name != null
                    ? Text(
                        '$name',
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: mainFontColor),
                      ): const SizedBox.shrink(),
                
                SizedBox(
                  height: 12,
                ),
                qrCodeBase64 != null
                    ? Container(
                        height: 280,
                        child: Image.memory(
                                          base64Decode(qrCodeBase64!),
                                          fit: BoxFit.cover,
                                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox( 
                  height: 10,
                ),
  //            Role
                user_role != null
                    ? Text(
                        '$user_role',
                        style: const TextStyle(fontSize: 20, color:black,fontWeight: FontWeight.bold),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 4,
                ),
                // Id
                id != null
                    ? Text(
                        '$id',
                        style: const TextStyle(fontSize: 25,color: mainFontColor,fontWeight: FontWeight.bold),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 10,
                ),
                
                // Container(
                //   padding: EdgeInsets.all(8),
                //   width: 350,
                //   decoration: BoxDecoration(
                //       color: buttoncolor,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: grey.withOpacity(0.03),
                //           spreadRadius: 10,
                //           blurRadius: 3,
                //           // changes position of shadow
                //         ),
                //       ]),
                //   child: Center(
                //       child:
                //           //Department
                //           Text(
                //               '$finaldepartment' + ' - ' + '$finaldept_abbr',
                //               style: TextStyle(color: white))),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.all(8),
                //   width: 350,
                //   decoration: BoxDecoration(
                //       color: buttoncolor,
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //           color: grey.withOpacity(0.03),
                //           spreadRadius: 10,
                //           blurRadius: 3,
                //           // changes position of shadow
                //         ),
                //       ]),
                //   child: Text(
                //     '$finalcourse_name' +
                //         '\nBatch: ' +
                //         '$finalbatch_start_year',
                //     style: TextStyle(color: white),
                //   ),
                // ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}

