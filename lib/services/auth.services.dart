import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthServices {
  Future<List> login({required String userId, required String password}) async {
    try {
      print('password is : $password');
      print('UserId is : $userId');
      final json = jsonEncode({
        'userID': userId,
        'password': password,
      });
      print('jsonn data $json');
      final uri = Uri.parse("http://157.173.219.135:3001/api/employeeLogin");
      print('before the api request');
      // Make HTTP POST request
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userID': userId,
          'password': password,
        }),
      );

      print('after the api request ${response.statusCode}');
      // Check if the status code is 200 (success)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseData = jsonDecode(response.body);

        // Assuming the API returns a success flag
        return [responseData['error'] == false];
      } else {
        // Log the error for debugging or monitoring
        print('Login failed. Status code: ${response.body}');
        return [false, jsonDecode(response.body)['message']];
      }
    } catch (error) {
      // Catch network or JSON parsing errors
      print('Error occurred during login: $error');
      return [false, error.toString()];
    }
  }
}
