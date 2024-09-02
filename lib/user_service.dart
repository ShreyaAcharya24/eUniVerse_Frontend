import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  Future<Map<String, dynamic>?> fetchUserProfile() async {
    print("\n\n *****");
    print("user service");
    print("\n\n *****");
    
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access');
    String? role = prefs.getString('role');

     print("\n\n ***** role:--  ");
    print("$role");
    print("\n\n *****");
    if (token != null && role != null) {
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var request = http.Request(
          'GET', Uri.parse('https://shreya42.pythonanywhere.com/user-profile/?role=$role'));
      request.headers.addAll(headers);
      // request.body = json.encode({'role': role});

      final response = await request.send();
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        print("\n IF PART #######*** ");
        print(responseBody);
         print("\n #######*** ");
        return jsonDecode(responseBody);
      } else {
        print("\n ELSEEE #######*** ");
        print(responseBody);
         print("\n #######*** ");
        // Handle error
        print('*****Failed to load profile data');
        return null;
      }
    } else {
      // Handle missing token or role
      print('Token or role is missing');
      return null;
    }
  }
}
