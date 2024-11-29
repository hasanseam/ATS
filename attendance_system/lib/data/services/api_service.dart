import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance_system/data/models/attendance.dart';

import '../models/student.dart';
import '../repositories/token_repoistory.dart';

class ApiService {
  final TokenRepository tokenRepository;
  ApiService({required this.tokenRepository});
  final String baseUrl = "http://192.168.10.102:3000";  // Replace with actual server URL
  final http.Client _client = http.Client();
  // Function to send the attendance data to the server
  Future<void> createAttendance(Attendance attendance) async {
    final token = await tokenRepository.getAccessToken();
    final url = Uri.parse('$baseUrl/attendance');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer $token'
      },
      body: jsonEncode(attendance.toJson()),
    );

    if (response.statusCode != 201) {
      print(response.statusCode);
      throw Exception('Failed to create attendance record');
    }
  }

  Future<Student> getStudentById(int id) async {
    final token = await tokenRepository.getAccessToken();
    final url = Uri.parse('$baseUrl/student/$id');

    try {
      final response = await _client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Student.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch student');
      }
    } catch (e) {
      print("Network or parsing error: $e");
      rethrow;
    }
  }

  void dispose() {
    _client.close();
  }

  Future<Map<String, String>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
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
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tokenRepository.saveTokens(accessToken: data['accessToken'], refreshToken: data['refreshToken']);
        return {
          'accessToken': data['accessToken'],
          'refreshToken': data['refreshToken'],
        };
      } else {
        throw Exception('Authentication failed: ${response.body}');
      }
    } catch (e) {
      print("Network or parsing error: $e");
      rethrow;
    }
  }

}
