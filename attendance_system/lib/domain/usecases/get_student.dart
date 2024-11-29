import 'package:attendance_system/data/models/student.dart';
import 'package:attendance_system/data/repositories/student_repository.dart';

class GetStudent {
  final StudentRepository studentRepository;

  GetStudent({required this.studentRepository});

  Future<Student> execute(int id) async {
    return await studentRepository.getStudentById(id);
  }
}
