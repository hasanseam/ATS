import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance_system/data/models/attendance.dart';

class ApiService {
  final String baseUrl = "http://192.168.10.102:3000";  // Replace with actual server URL
  final http.Client _client = http.Client();
  // Function to send the attendance data to the server
  Future<void> createAttendance(Attendance attendance) async {
    final url = Uri.parse('$baseUrl/attendance');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(attendance.toJson()),
    );

    if (response.statusCode != 201) {
      print(response.statusCode);
      throw Exception('Failed to create attendance record');
    }
  }

  void dispose() {
    _client.close();
  }

  Future<Map<String, String>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    print("Starting login request...");

    try {
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          print("Request timed out");
          throw TimeoutException('Request took too long');
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'accessToken': data['accessToken'],
          'refreshToken': data['refreshToken'],
        };
      } else {
        print("Authentication failed with status: ${response.statusCode}");
        print("Error response: ${response.body}");
        throw Exception('Authentication failed: ${response.body}');
      }
    } catch (e) {
      print("Network or parsing error: $e");
      rethrow;
    }
  }

  Future<bool> checkConnection() async {
    try {
      final url = Uri.parse('$baseUrl/test-connection');
      final response = await _client.get(url)
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      print("Connection check failed: $e");
      return false;
    }
  }
  
}
