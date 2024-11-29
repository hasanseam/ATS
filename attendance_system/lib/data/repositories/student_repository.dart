import 'package:attendance_system/data/models/student.dart';
import 'package:attendance_system/data/services/api_service.dart';

class StudentRepository {
  final ApiService apiService;

  StudentRepository({required this.apiService});

  Future<Student> getStudentById(int id) async {
    return await apiService.getStudentById(id);
  }
}
