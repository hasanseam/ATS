import 'package:bloc/bloc.dart';
import 'package:attendance_system/domain/usecases/create_attendance.dart';
import 'package:attendance_system/data/models/attendance.dart';

// Define the events
abstract class AttendanceEvent {}

class CreateAttendanceEvent extends AttendanceEvent {
  final Attendance attendance;

  CreateAttendanceEvent(this.attendance);
}

// Define the states
abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceCreating extends AttendanceState {}

class AttendanceCreatedSuccess extends AttendanceState {}

class AttendanceCreatedFailure extends AttendanceState {
  final String error;
  AttendanceCreatedFailure(this.error);
}

// Define the BLoC
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final CreateAttendance createAttendance;

  // Constructor for AttendanceBloc
  AttendanceBloc({required this.createAttendance}) : super(AttendanceInitial()) {
    // Register handlers for events
    on<CreateAttendanceEvent>((event, emit) async {
      emit(AttendanceCreating());  // Emit the loading state

      try {
        // Execute the use case to create attendance
        await createAttendance.execute(event.attendance);
        emit(AttendanceCreatedSuccess()); // Success state if creation is successful
      } catch (error) {
        emit(AttendanceCreatedFailure(error.toString())); // Failure state if an error occurs
      }
    });
  }
}
