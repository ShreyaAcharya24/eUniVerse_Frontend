import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/forgotPassword.dart';
import 'package:GLSeUniVerse/loadScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:GLSeUniVerse/users.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController password = TextEditingController();

  var _enrollment = '';
  var _password = '';

  bool obscure_Text = true; //for hidding the password

  void _showpass() {
    setState(() {
      obscure_Text = !obscure_Text;
    });
  }

  var roles = ["Student", "Alumni", "Staff", "Guard"];
  String? role;
  // Check User Credentials
  main() async {
    checkrole = role!;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://shreya42.pythonanywhere.com/user-login/'));
    request.body = json.encode({
      "username": "$_enrollment",
      "password": "$_password",
      "role": "$role"
    });
    request.headers.addAll(headers);
    print("******Before login ApI *********");

    final response = await request.send();
    if (response.statusCode == 200) {
      print("******After login ApI *********");
      final data = jsonDecode(await response.stream.bytesToString());

      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('refresh', data['refresh']);
      await sharedPreferences.setString('access', data['access']);
      await sharedPreferences.setString('role', data['role']);
      await sharedPreferences.setInt('id', data['id']);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loadScreen(),
          ));
    } else if (response.statusCode == 400) {
      final data = jsonDecode(await response.stream.bytesToString());
      print(data);
      Fluttertoast.showToast(
          msg: data['error'] ?? 'Error occurred 400',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    } else if (response.statusCode == 401) {
      final data = jsonDecode(await response.stream.bytesToString());
      Fluttertoast.showToast(
          msg: data['error'] ?? 'Invalid Credentials 401',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
      print(response.reasonPhrase);
    } else {
      print("Unexpected error: ${response.statusCode}");
      Fluttertoast.showToast(
          msg: 'Unexpected Error!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
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
              height: 50,
            ),
            Container(
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
                        controller: _email,
                        cursorColor: black,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: black),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor: black,
                            hintText: "Username",
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
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
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xff67727d)),
                      ),
                      TextField(
                        controller: password,
                        obscureText: obscure_Text,
                        cursorColor: black,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: black),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            prefixIconColor: Colors.black,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _showpass();
                                },
                                icon: Icon(Icons.remove_red_eye_rounded)),
                            suffixIconColor: Colors.black,
                            hintText: "Password",
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
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
              width: 350,
              child: DropdownButton(
                hint: Text("Select Role"),
                value: role,
                items: roles.map((String role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (String? selectedValue) {
                  setState(() {
                    role = selectedValue!;
                  });
                },
                style: TextStyle(fontSize: 15, color: Colors.black),
                isExpanded: true,
                elevation: 8,
                underline: Container(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                _enrollment = _email.text;
                _password = password.text;

                main();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: buttoncolor,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return forgotPassword();
                        },
                      ));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
