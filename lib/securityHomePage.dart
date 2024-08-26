import 'dart:convert';

import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/loader.dart';
import 'package:GLSeUniVerse/loginPage.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:GLSeUniVerse/visitorEntryPage.dart';
import 'package:GLSeUniVerse/visitorInView.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class securityPage extends StatefulWidget {
  const securityPage({super.key});

  @override
  State<securityPage> createState() => _securityPageState();
}

class _securityPageState extends State<securityPage> {
  TextEditingController _enroll = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            CircleAvatar(
              radius: 80,
              //backgroundImage: AssetImage('images/profile.png'),
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                  //   width: 350,
                  //   height: 50,
                  //   padding: EdgeInsets.only(left: 14, bottom: 10, right: 14),
                  //   decoration: BoxDecoration(
                  //     color: Color.fromARGB(255, 221, 237, 245),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: TextField(
                  //     controller: _enroll,
                  //     cursorColor: black,
                  //     style: TextStyle(
                  //         fontSize: 17, fontWeight: FontWeight.w500, color: black),
                  //     decoration: InputDecoration(
                  //         prefixIcon: Icon(Icons.email_outlined),
                  //         prefixIconColor: black,
                  //         hintText: "Enrollment Number",
                  //         border: InputBorder.none),
                  //   ),
                  // ),

                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(25),
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
                          controller: _enroll,
                          cursorColor: black,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: black),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.numbers_outlined),
                              prefixIconColor: black,
                              hintText: "Search Username",
                              border: InputBorder.none),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            print("Pressed");
                            final username = _enroll.text;
                            print(username);
                            var headers = {
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'GET',
                                      Uri.parse(
                                          'https://poojan16.pythonanywhere.com/api/searchUser/'));
                                  request.body = json.encode({
                                    "username": "$username",
                                    });

                                   request.headers.addAll(headers);
                                  // http.StreamedResponse response = await request.send();
                                  final response = await request.send();
                                  if (response.statusCode == 200) {
                                      print("Data Found");

                                       //print(await response.stream.bytesToString());
                                      final qrdata = jsonDecode(await response.stream.bytesToString());
                                      print(qrdata);
                                      //print(qrdata['data']['name']);
                                      //print(qrdata['data']['department']);

                                      finalqr_name = qrdata['data']['name'];
                                      finalqr_department = qrdata['data']['department'];
                                      finalqr_program = qrdata['data']['program'];

                                      Navigator.push(context,
                                      MaterialPageRoute(
                                      builder: (context) => loader()));

                                      
                                      if(qr_role == 'Staff'){

                                        finalqr_name = qrdata['data']['name'];
                                        finalqr_department = qrdata['data']['department'];
                                        finalqr_program = 'Not Applicable';
                                        finalqr_profile = qrdata['data']['profile'];

                                        Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) => loader()));
                                      }
                                      else if(qr_role == 'Student' || qr_role == 'Alumni')
                                      {
                                        finalqr_name = qrdata['data']['name'];
                                        finalqr_department = qrdata['data']['department'];
                                        finalqr_program = qrdata['data']['program'];
                                        finalqr_profile = qrdata['data']['profile'];

                                        Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) => loader()));

                                      }
                                      // print(finalqr_name);
                                      // print(finalqr_department);
                                      // print(finalqr_program);
      
                                  }
                                  else if(response.statusCode == 404){
                                      print("Invalid Data");

                                       //print(await response.stream.bytesToString());
                                      final qrdata = jsonDecode(await response.stream.bytesToString());
                                      print(qrdata);
                                      Fluttertoast.showToast(
                                      msg: qrdata['msg'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 16.0);
                                        
                                      
                                  }
                                  else {
                                        print("User Not Found");
                                        Fluttertoast.showToast(
                                        msg: 'Something Went Wrong',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        fontSize: 16.0);
                                        print(response.reasonPhrase);
                                  }



                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => userDetails(),
                            //     ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 50,
            ),

            Container(
              height: 320,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => QRCodeScannerScreen(),
                              //     ));
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SimpleBarcodeScannerPage(),
                                  ));
                              setState(() async {
                                if (res is String && res.isNotEmpty) {
                                  final data = jsonDecode(res);
                                  // final username;
                                  // final role;
                                  // final key;

                                  //final username = data['']
                                  print(data);
                                  
                                  if(data['role'] == 'Student' || data['role'] == "Alumni")
                                  {
                                    qr_username = data['enrolment'];
                                    qr_role = data['role'];
                                    qr_key = data['key'];
                                  
                                  }
                                  else if(data['role'] == 'Staff')
                                  {
                                    qr_username = data['email'];
                                    qr_role = data['role'];
                                    qr_key = data['key'];
                                  
                                  }
                                  print(qr_username);
                                  // result = res;
                                  print(data);
                                  //print(data['enrolment']);
                                  final username = qr_username;
                                  final role = qr_role;
                                  final key = qr_key;
                                  var headers = {
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request(
                                      'POST',
                                      Uri.parse(
                                          'https://poojan16.pythonanywhere.com/api/verifyUser/'));
                                  request.body = json.encode({
                                    "username": "$username",
                                    "key": "$key",
                                    "role": "$role",
                                  });

                                   request.headers.addAll(headers);
                                  // http.StreamedResponse response = await request.send();
                                  final response = await request.send();
                                  if (response.statusCode == 500) { 
                                      print("QR Data Found");

                                       //print(await response.stream.bytesToString());
                                      final qrdata = jsonDecode(await response.stream.bytesToString());
                                      print(qrdata);
                                      //print(qrdata['data']['name']);
                                      //print(qrdata['data']['department']);
                                      
                                      if(qr_role == 'Staff'){

                                        finalqr_name = qrdata['data']['name'];
                                        finalqr_department = qrdata['data']['department'];
                                        finalqr_program = 'Not Applicable';
                                        finalqr_profile = qrdata['data']['profile'];

                                        Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) => loader()));
                                      }
                                      else if(qr_role == 'Student' || qr_role == 'Alumni')
                                      {
                                        finalqr_name = qrdata['data']['name'];
                                        finalqr_department = qrdata['data']['department'];
                                        finalqr_program = qrdata['data']['program'];
                                        finalqr_profile = qrdata['data']['profile'];

                                        Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) => loader()));

                                      }
                                      // print(finalqr_name);
                                      // print(finalqr_department);
                                      // print(finalqr_program);
      
                                  }
                                  else {
                                    // AwesomeDialog(
                                    //   context: context,
                                    //   dialogType: DialogType.error,
                                    //   animType: AnimType.topSlide,
                                    //   showCloseIcon: true,
                                    //   title: response.reasonPhrase,
                                    //   btnOkOnPress: (){},
                                    //   btnOkIcon: Icons.cancel,
                                    //   btnOkColor: buttoncolor, 

                                    // ).show();
                                    //     
                                    print("User Not Found");
                                    Fluttertoast.showToast(
                                    msg: 'Invalid QR!!!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16.0);
                                    print(response.reasonPhrase);
                                  }
                                }
                              });
                              print("1st Clicked");
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
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
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.qr_code_2_outlined,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Scan QR Code",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              // Text(
                                              //   "Receiving Payment from company",
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: black
                                              //           .withOpacity(0.5),
                                              //       fontWeight:
                                              //           FontWeight.w400),
                                              // ),
                                            ]),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.end,
                                    //       children: [
                                    //         Text(
                                    //           "\$250",
                                    //           style: TextStyle(
                                    //               fontSize: 15,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: black),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => visitorEntry(),
                                  ));
                              //print("1st Clicked");
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
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
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.bookmark_add_rounded,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Visitor Entry",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              // Text(
                                              //   "Receiving Payment from company",
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: black
                                              //           .withOpacity(0.5),
                                              //       fontWeight:
                                              //           FontWeight.w400),
                                              // ),
                                            ]),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => visitorInView(),
                                  ));
                              //print("1st Clicked");
                            },
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25,
                                right: 25,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
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
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: arrowbgColor,
                                        borderRadius: BorderRadius.circular(15),
                                        // shape: BoxShape.circle
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.directions_run_rounded,
                                        size: 30,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Visitor In List",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              
                                            ]),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                            
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton(onPressed: () async {
              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              await sharedPreferences.clear();
              print('okay!');

              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return loginPage();
                },
              ));
            }, child: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
