// qr_code_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class QRCodeService {
  // Base URL of the API

  static const String baseUrl = "https://shreya42.pythonanywhere.com/scan-qr/";

  // Method to scan the QR code
  static Future<Map<String, dynamic>> scanQRCode(String qrCodeData) async {
    print("\n\n**** Inside QR API ");
  
    try {
      // Prepare the request body
      final Map<String, String> requestBody = {'qr_code': qrCodeData};

      // Make the POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Successfully received data
        print("\n***200 data received  ${response.body} **\n");
        return json.decode(response.body);
      } else {
        // Handle various error cases based on status code
        print("\n*** Error  ${response.body} **\n");
        final errorData = json.decode(response.body);
        // Fluttertoast.showToast(
        //     msg: "Error: ${errorData['error']}",
        //     toastLength: Toast.LENGTH_LONG);
        return {'error': errorData['error'], 'details': errorData['details'] ?? ''};
      }
    } catch (e) {
      // Handle any other exceptions
      Fluttertoast.showToast(
          msg: "An error occurred: $e", toastLength: Toast.LENGTH_LONG);
      return {'error': 'An unexpected error occurred', 'details': e.toString()};
    }
  }
}
