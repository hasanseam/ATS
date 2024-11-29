class Student {
  final int id;
  final String name;

  Student({
    required this.id,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'];
    return Student(
      id: data[0] as int,
      name: data[1] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
