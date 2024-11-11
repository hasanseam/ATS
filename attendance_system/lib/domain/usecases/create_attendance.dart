import 'package:attendance_system/data/models/attendance.dart';
import 'package:attendance_system/data/repositories/attendance_repository.dart';

class CreateAttendance {
  final AttendanceRepository attendanceRepository;

  CreateAttendance({required this.attendanceRepository});

  Future<void> execute(Attendance attendance) async {
    await attendanceRepository.createAttendance(attendance);
  }
}
