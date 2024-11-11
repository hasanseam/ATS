import 'package:get_it/get_it.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/attendance/attendance_bloc.dart';
import 'data/repositories/attendance_repository.dart';
import 'data/services/api_service.dart';
import 'domain/usecases/create_attendance.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthBloc());
  locator.registerLazySingleton<ApiService>(() => ApiService()); // Registering ApiService
// Register AttendanceRepository, passing in the ApiService dependency
  locator.registerLazySingleton<AttendanceRepository>(() => AttendanceRepository(apiService: locator()));
// Now register CreateAttendance with the already registered AttendanceRepository
  locator.registerLazySingleton<CreateAttendance>(() => CreateAttendance(attendanceRepository: locator()));
  // Register all your other BLoCs here
}
