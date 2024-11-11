import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../../blocs/attendance/attendance_bloc.dart';
import '../../data/models/attendance.dart';
import '../../domain/usecases/create_attendance.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../data/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String scannedData = "No data scanned yet.";

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        scannedData = result.rawContent.isNotEmpty ? result.rawContent : "No data scanned.";
      });

      if (scannedData != "No data scanned.") {
        // Create an attendance object and dispatch it to BLoC
        final attendance = Attendance(personName: scannedData);
        BlocProvider.of<AttendanceBloc>(context).add(CreateAttendanceEvent(attendance));
      }
    } on PlatformException catch (e) {
      setState(() {
        scannedData = e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the Home Screen!"),
            ElevatedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Scan QR Code"),
              onPressed: _scan,
            ),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: scannedData),
              decoration: InputDecoration(labelText: "Scanned Data"),
            ),
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceCreating) {
                  return CircularProgressIndicator();
                } else if (state is AttendanceCreatedSuccess) {
                  return Text("Attendance recorded successfully!");
                } else if (state is AttendanceCreatedFailure) {
                  print(state.error);
                  return Text("Failed to create attendance: ${state.error}");
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
