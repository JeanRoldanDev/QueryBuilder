class People {
  People({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory People.fromJson(Map<String, dynamic> row) {
    return People(
      id: row['id'] as int,
      firstName: row['first_name'] as String,
      lastName: row['last_name'] as String,
      age: int.parse(row['age'].toString()),
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final int age;
}
