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
      studentID: json['studentID'],
      studentName: json['studentName'],
      inOut: json['inOut'],
      staff: json['staff'],
      macAddress: json['macAddress'],
    );
  }

  // Method to convert Attendance object to JSON
  Map<String, dynamic> toJson() {
    return {
      'studentID': studentID,
      'studentName': studentName,
      'inOut': inOut,
      'staff': staff,
      'macAddress': macAddress,
    };
  }
}
