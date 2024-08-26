import 'package:GLSeUniVerse/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class visitorEntry extends StatefulWidget {
  const visitorEntry({super.key});

  @override
  State<visitorEntry> createState() => _visitorEntryState();
}

class _visitorEntryState extends State<visitorEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Center(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(8),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(40),
                  //   color: buttoncolor,
                  // ),
                  child: Center(
                    child: Text(
                      "Visitor Entry",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainFontColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Contact"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Purpose"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Gate No"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Get.toNamed('/cameraOpen');
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      label: Text(
                        "Click Picture",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    // Get.toNamed('/cameraOpen');
                  },
                  child: Text(
                    "Add Entry",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttoncolor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
