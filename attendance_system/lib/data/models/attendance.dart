class Attendance {
  final String studentID;
  final String studentName;
  final String inOut;
  final String staff;
  final String macAddress;

  Attendance({
    required this.studentID,
    required this.studentName,
    required this.inOut,
    required this.staff,
    required this.macAddress,
  });

  // Factory method to create an Attendance object from a JSON response
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      studentID: json['student_id'],
      studentName: json['student_name'],
      inOut: json['in_out'],
      staff: json['staff'],
      macAddress: json['mac_address'],
    );
  }

  // Method to convert Attendance object to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentID,
      'student_name': studentName,
      'in_out': inOut,
      'staff': staff,
      'mac_address': macAddress,
    };
  }
}
