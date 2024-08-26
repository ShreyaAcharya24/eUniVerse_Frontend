import 'package:GLSeUniVerse/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: visitorInView(),
//     );
//   }
// }

class visitorInView extends StatefulWidget {
  @override
  _visitorInViewState createState() => _visitorInViewState();
}

class _visitorInViewState extends State<visitorInView> {
  List<Map<String, dynamic>> visitors = [];

  @override
  void initState() {
    super.initState();
    fetchVisitorData();
  }

  Future<void> fetchVisitorData() async {
    final response = await http.get(Uri.parse('https://poojan16.pythonanywhere.com/visitorstatus'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        visitors = responseData.cast<Map<String, dynamic>>();

        print(visitors);
      });
    } else {
      throw Exception('Failed to load visitor data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor List', style: TextStyle(color: white),),
        backgroundColor: mainFontColor,
      ),
      body: ListView.builder(
        itemCount: visitors.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(visitors[index]['pass_no']), radius: 30,),
              title: Text(visitors[index]['full_name']),
              subtitle: Text(visitors[index]['contact'] + '\n' + 'Gate: ' + visitors[index]['entry_gate']),
              
              trailing: GestureDetector(
                child: Icon(Icons.directions_run_rounded, size: 40, color: buttoncolor,),
                
                onDoubleTap
                : () async {
                  var pass_no = visitors[index]['pass_no'];
                  var headers = {'Content-Type': 'application/json'};
                  var request = http.Request('POST',
                    Uri.parse('https://poojan16.pythonanywhere.com/statusChange'));
                  request.body = json.encode({
                    "pass_no": "$pass_no",
                  });
                  request.headers.addAll(headers);
                  // http.StreamedResponse response = await request.send();
                  final response = await request.send();

                  if (response.statusCode == 200) {
                    print("User Found");

                    //print(await response.stream.bytesToString());
                    final data = jsonDecode(await response.stream.bytesToString());
                    print(data);

                    Fluttertoast.showToast(
                    msg: data['Success'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 16.0);
      
                    
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return visitorInView();
                    },)).then((value){setState(() {
                      
                    });});
                    
                  }
                  //visitors.removeAt(index);
                
                  // setState(() {
                    
                  // });
                },
                
              ),
            ),
          );
        },
      ),
    );
  }
}