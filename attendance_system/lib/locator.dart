import 'package:get_it/get_it.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/attendance/attendance_bloc.dart';
import '../data/repositories/attendance_repository.dart';
import '../data/services/api_service.dart';
import '../domain/usecases/create_attendance.dart';
import 'data/repositories/token_repoistory.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Repositories
  locator.registerLazySingleton(() => TokenRepository());
  locator.registerLazySingleton<AttendanceRepository>(
          () => AttendanceRepository(apiService: locator())
  );

  // Services
  locator.registerLazySingleton<ApiService>(
          () => ApiService(tokenRepository: locator())
  );

  // Use Cases
  locator.registerLazySingleton<CreateAttendance>(
          () => CreateAttendance(attendanceRepository: locator())
  );

  // BLoCs
  locator.registerFactory(() => AuthBloc(
    apiService: locator()
  ));

  locator.registerFactory(() => AttendanceBloc(
      createAttendance: locator()
  ));
}
