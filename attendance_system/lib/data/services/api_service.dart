import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:attendance_system/data/models/attendance.dart';

class ApiService {
  final String baseUrl = "http://192.168.10.102:3000";  // Replace with actual server URL

  // Function to send the attendance data to the server
  Future<void> createAttendance(Attendance attendance) async {
    final url = Uri.parse('$baseUrl/attendance');
    print(url);
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
}
