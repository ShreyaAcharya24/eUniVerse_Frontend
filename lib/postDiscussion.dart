// ignore: file_names
// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:ffi';

import 'package:GLSeUniVerse/alumni_home.dart';
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class postDiscussion extends StatefulWidget {
  const postDiscussion({super.key});

  @override
  State<postDiscussion> createState() => _postDiscussionState();
}

class _postDiscussionState extends State<postDiscussion> {



  TextEditingController pdiscuss = TextEditingController();
  TextEditingController ptitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Discussion",
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mainFontColor,
      ),
      backgroundColor: arrowbgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 420,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 25,
                ),
                
                TextField(
                  controller: ptitle,
                  // maxLines: 10,
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Give title",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: pdiscuss,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Write your Discription about Discussion...",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      int? id = prefs.getInt('id');
                      String post_title = ptitle.text;
                      String post_content = pdiscuss.text;
                      print(post_title);
                      print(post_content);
                      print(id);
                      //checkrole = role!;
                      var headers = {'Content-Type': 'application/json'};
                      var request = http.Request(
                          'POST',
                          Uri.parse(
                              'http://shreya42.pythonanywhere.com/create-post/'));
                      request.body = json.encode({
                        "id": "$id",
                        "post_title": "$post_title",
                        "post_content": "$post_content"
                      });
                      request.headers.addAll(headers);
                      // http.StreamedResponse response = await request.send();
                      final response = await request.send();

                      if (response.statusCode == 201) {
                        print("Posted Successfully");
                        final data =
                            jsonDecode(await response.stream.bytesToString());
                        print(data);

                        Fluttertoast.showToast(
                            msg: data['success'],
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => alumni_home(),
                            ));
                      } else {
                        print("Not valid!!!");
                        final data =
                            jsonDecode(await response.stream.bytesToString());
                        print(data);
                        Fluttertoast.showToast(
                            msg: data['error'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      "Post Your Discussion",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttoncolor,
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
