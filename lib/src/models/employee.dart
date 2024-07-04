import 'dart:ffi';

class Employee {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String dob;
  final String nic;
  final String position;
  final String salary;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.dob,
    required this.nic,
    required this.position,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '_id': String id,
      'firstName': String firstName,
      'lastName': String lastName,
      'address': String address,
      'dob': String dob,
      'phoneNumber': String phoneNumber,
      'nic': String nic,
      'position': String position,
      'salary': String salary,
      } =>
          Employee(
            id: id,
            firstName: firstName,
            lastName: lastName,
            address: address,
            position: position,
            dob: dob,
            nic: nic,
            salary: salary,
            phoneNumber: phoneNumber,
          ),
      _ => throw const FormatException('Failed to load employees.'),
    };
  }
}