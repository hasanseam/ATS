import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'blocs/auth/auth_bloc.dart'; // Your AuthBloc
import 'blocs/attendance/attendance_bloc.dart'; // Your AttendanceBloc
import 'data/repositories/attendance_repository.dart';
import 'data/services/api_service.dart';
import 'domain/usecases/create_attendance.dart';
import 'presentation/screens/login_screen.dart'; // Your login screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();  // Assuming this is already implemented
    final AttendanceRepository attendanceRepository = AttendanceRepository(apiService: apiService);
    final CreateAttendance createAttendance = CreateAttendance(attendanceRepository: attendanceRepository);
    return MultiBlocProvider(
      providers: [
        // Directly providing AuthBloc globally
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(apiService:apiService),
        ),
        // Directly providing AttendanceBloc globally
        BlocProvider<AttendanceBloc>(
          create: (context) => AttendanceBloc(createAttendance: createAttendance), // You can pass parameters here if needed
        ),
        // Add more BLoCs if needed
      ],
      child: MaterialApp(
        title: 'Attendance System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
