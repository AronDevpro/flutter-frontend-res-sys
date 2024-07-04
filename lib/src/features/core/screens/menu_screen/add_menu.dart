import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:http/http.dart' as http;

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> createMenu() async {
    final response = await http.post(
      Uri.parse(API_MENU),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'itemName': _itemNameController.text,
        'price': _priceController.text,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, '/menu');
    } else {
      throw Exception('Failed to create menu.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu'),
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
              controller: _itemNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Item Name',
                label: Text("Item Name")
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: _priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'price',
                label: Text("Price")
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: createMenu,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
