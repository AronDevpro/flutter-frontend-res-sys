class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '_id': String id,
      'name': String name,
      'email': String email,
      'phoneNumber': String phoneNumber,
      } =>
          Customer(
            id: id,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  // @override
  // String toString() {
  //   return 'Customer{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber}';
  // }
}

//   // Sample customers
//   final AllCustomers = [
//     Customer(
//       id: 1,
//       name: 'John Doe',
//       email: 'john.doe@example.com',
//       phoneNumber: '123-456-7890',
//     ),
//     Customer(
//       id: 2,
//       name: 'Jane Smith',
//       email: 'jane.smith@example.com',
//       phoneNumber: '987-654-3210',
//     ),
//     Customer(
//       id: 3,
//       name: 'Alice Johnson',
//       email: 'alice.johnson@example.com',
//       phoneNumber: '555-123-4567',
//     ),
//     Customer(
//       id: 4,
//       name: 'Bob Brown',
//       email: 'bob.brown@example.com',
//       phoneNumber: '444-567-8910',
//     ),
//   ];
// // }
