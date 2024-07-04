import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:http/http.dart' as http;

import '../../../../models/menu.dart';

class UpdateMenu extends StatefulWidget {
  final Menu menu;

  const UpdateMenu({super.key, required this.menu});

  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

class _UpdateMenuState extends State<UpdateMenu> {
  late TextEditingController _itemNameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController(text: widget.menu.itemName);
    _priceController =
        TextEditingController(text: widget.menu.price.toString());
  }

    @override
    void dispose() {
      _itemNameController.dispose();
      _priceController.dispose();
      super.dispose();
    }

    Future<void> updateMenu() async {
      final response = await http.put(
        Uri.parse('$API_MENU/${widget.menu.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'itemName': _itemNameController.text,
          'price': _priceController.text,
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/menu');
      } else {
        throw Exception('Failed to update menu.');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('UpdateMenu'),
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
                controller: _priceController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price',
                    label: Text("Price")
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: updateMenu,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      );
    }
  }
