import 'package:attendance_system/blocs/student/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/attendance/attendance_bloc.dart';
import 'locator.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => locator<AuthBloc>(),
        ),
        BlocProvider<AttendanceBloc>(
          create: (context) => locator<AttendanceBloc>(),
        ),
        BlocProvider<StudentBloc>(
            create: (context)=> locator<StudentBloc>()
        )
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
