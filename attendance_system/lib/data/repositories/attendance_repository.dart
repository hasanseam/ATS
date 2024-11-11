import 'package:attendance_system/data/models/attendance.dart';
import 'package:attendance_system/data/services/api_service.dart';

class AttendanceRepository {
  final ApiService apiService;

  AttendanceRepository({required this.apiService});

  Future<void> createAttendance(Attendance attendance) async {
    await apiService.createAttendance(attendance);
  }
}
