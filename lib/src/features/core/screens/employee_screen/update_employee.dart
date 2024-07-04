import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:http/http.dart' as http;

import '../../../../models/employee.dart';


class UpdateEmployee extends StatefulWidget {
  final Employee employee;

  const UpdateEmployee({super.key, required this.employee});

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _dobController;
  late TextEditingController _salaryController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _positionController;
  late TextEditingController _nicController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.employee.firstName);
    _lastNameController = TextEditingController(text: widget.employee.lastName);
    _addressController = TextEditingController(text: widget.employee.address);
    _dobController = TextEditingController(text: widget.employee.dob);
    _positionController = TextEditingController(text: widget.employee.position);
    _nicController = TextEditingController(text: widget.employee.nic);
    _salaryController = TextEditingController(text: widget.employee.salary);
    _phoneNumberController =
        TextEditingController(text: widget.employee.phoneNumber);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _salaryController.dispose();
    _positionController.dispose();
    _nicController.dispose();
    super.dispose();
  }

  Future<void> updateEmployee() async {
    final bodyData = jsonEncode(<String, dynamic>{
      'phoneNumber': _phoneNumberController.text,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'address': _addressController.text,
      'dob': _dobController.text,
      'salary': _salaryController.text,
      'position': _positionController.text,
      'nic': _nicController.text,
    });
    final response = await http.put(
      Uri.parse('$API_URL/${widget.employee.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyData
    );
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/employee');
    } else {
      throw Exception('Failed to update employee.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Employee'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'First Name',
                        label: Text("First Name"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Last Name',
                        label: Text("Last Name"),
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
                  label: Text("Address"),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  label: Text("Phone Number"),
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
                        label: Text("DOB"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3,),
                  Expanded(
                    child: TextField(
                      controller: _nicController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'NIC',
                        label: Text("NIC"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _salaryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Salary',
                  label: Text("Salary"),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _positionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Position',
                  label: Text("Position"),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: updateEmployee,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
