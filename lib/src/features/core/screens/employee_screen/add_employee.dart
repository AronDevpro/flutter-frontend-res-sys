import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}
class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> createCustomer() async {
    final response = await http.post(
      Uri.parse(API_EMPLOYEES),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': _phoneNumberController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'address': _addressController.text,
        'dob': _dobController.text,
        'salary': _salaryController.text,
        'position': _positionController.text,
        'nic': _nicController.text,
      }),
    );

    print(response.body);

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/employee');
    } else {
      throw Exception('Failed to create customer.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'First Name',
                      label: Text('First Name')
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Last Name',
                        label: Text('Last Name')
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Address',
                  label: Text('Address')
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone Number',
                  label: Text('Phone Number')
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'DOB',
                        label: Text('DOB')
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                   child: TextField(
                     controller: _nicController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'NIC',
                        label: Text('NIC')
                    ),
                    ),
                 ),
              ],
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: _salaryController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Salary',
                  label: Text('Salary')
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _positionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Position',
                  label: Text('Position')
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: createCustomer,
                child: const Text("Save")
            )
          ],
        ),
      ),
    );
  }
}
