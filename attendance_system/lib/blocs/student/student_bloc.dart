import 'package:bloc/bloc.dart';
import 'package:attendance_system/domain/usecases/get_student.dart';
import 'package:attendance_system/data/models/student.dart';

// Events
abstract class StudentEvent {}

class GetStudentEvent extends StudentEvent {
  final int studentId;
  GetStudentEvent(this.studentId);
}

// States
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoadSuccess extends StudentState {
  final Student student;
  StudentLoadSuccess(this.student);
}

class StudentLoadFailure extends StudentState {
  final String error;
  StudentLoadFailure(this.error);
}

// BLoC
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudent getStudent;

  StudentBloc({required this.getStudent}) : super(StudentInitial()) {
    on<GetStudentEvent>((event, emit) async {
      emit(StudentLoading());

      try {
        final student = await getStudent.execute(event.studentId);

        if (student != null) {
          emit(StudentLoadSuccess(student));
        } else {
          emit(StudentLoadFailure('Student not found'));
        }

      } catch (error) {
        emit(StudentLoadFailure(error.toString()));
      }
    });
  }
}
