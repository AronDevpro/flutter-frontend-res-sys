import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:http/http.dart' as http;

import '../../../../models/customers.dart';


class UpdateCustomer extends StatefulWidget {
  final Customer customer;

  const UpdateCustomer({super.key, required this.customer});

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _emailController = TextEditingController(text: widget.customer.email);
    _phoneNumberController =
        TextEditingController(text: widget.customer.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> updateCustomer() async {
    final response = await http.put(
      Uri.parse('$API_URL/${widget.customer.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': _nameController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/');
    } else {
      throw Exception('Failed to update customer.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Customer'),
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
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Full Name',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: updateCustomer,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
