import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/home.dart';
import 'package:GLSeUniVerse/userDetails.dart';
import 'package:flutter/material.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 420,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Email", suffixIcon: Icon(Icons.edit)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Contact",
                              suffixIcon: Icon(Icons.edit)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: Icon(Icons.edit)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => home(),
                          ));
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
