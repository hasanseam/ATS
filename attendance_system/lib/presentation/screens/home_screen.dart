import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../../blocs/attendance/attendance_bloc.dart';
import '../../data/models/attendance.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String staffName; // Pass staff name from the LoginScreen
  HomeScreen({required this.staffName});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _studentNameController = TextEditingController();
  String? _inOutValue; // Dropdown value for "In" or "Out"
  String? _macAddress; // Device MAC Address

  @override
  void initState() {
    super.initState();
    _fetchMacAddress();
  }

  Future<void> _fetchMacAddress() async {
    try {
      String? macAddress = '00:1B:44:11:3A:C6'; // Fetch MAC address
      setState(() {
        _macAddress = macAddress;
      });
    } catch (e) {
      setState(() {
        _macAddress = "Error fetching MAC Address";
      });
    }
  }

  Future<void> _scanQRCode() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result.rawContent.isNotEmpty) {
        setState(() {
          _studentIDController.text = result.rawContent; // Populate StudentID
        });
      }
    } catch (e) {
      setState(() {
        _studentIDController.text = "Error scanning QR code";
      });
    }
  }

  void _saveAttendance() {
    if (_studentIDController.text.isEmpty ||
        _studentNameController.text.isEmpty ||
        _inOutValue == null ||
        _macAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final attendance = Attendance(
      studentID: _studentIDController.text,
      studentName: _studentNameController.text,
      inOut: _inOutValue!,
      staff: widget.staffName,
      macAddress: _macAddress!
    );

    BlocProvider.of<AttendanceBloc>(context).add(CreateAttendanceEvent(attendance));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Attendance saved successfully!")),
    );

    // Clear fields
    _studentIDController.clear();
    _studentNameController.clear();
    setState(() {
      _inOutValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.qr_code_scanner),
                label: Text("Scan QR Code"),
                onPressed: _scanQRCode,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _studentIDController,
                decoration: InputDecoration(
                  labelText: "Student ID",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _studentNameController,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _inOutValue,
                decoration: InputDecoration(
                  labelText: "In/Out",
                  border: OutlineInputBorder(),
                ),
                items: ["In", "Out"].map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _inOutValue = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Staff",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                controller: TextEditingController(text: widget.staffName),
                enabled: false, // Read-only field
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "MAC Address",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                controller: TextEditingController(text: _macAddress ?? "Fetching..."),
                enabled: false, // Read-only field
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAttendance,
                  child: Text("Save Attendance"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
