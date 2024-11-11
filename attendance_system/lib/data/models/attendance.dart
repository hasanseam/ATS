class Attendance {
  final String personName;

  Attendance({required this.personName});

  // Factory method to create an Attendance object from a JSON response
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(personName: json['person_name']);
  }

  // Method to convert Attendance object to JSON
  Map<String, dynamic> toJson() {
    return {
      'person_name': personName,
    };
  }
}
