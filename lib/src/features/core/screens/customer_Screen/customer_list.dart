import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/features/core/screens/customer_Screen/update_customer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/server.dart';
import '../../../../models/customers.dart';


class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late Future<List<Customer>> futureCustomers;

  Future<List<Customer>> getData() async {
    final response = await http.get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<http.Response> deleteCustomer(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('$API_URL/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  void initState() {
    super.initState();
    futureCustomers = getData();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/employee');
        break;
      case 2:
        Navigator.pushNamed(context, '/menu');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Customer>>(
        future: futureCustomers,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            final customers = snapshot.data!;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        onPressed: (BuildContext context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateCustomer(customer: customer),
                            ),
                          );
                        },
                        backgroundColor: Colors.amberAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        onPressed: (BuildContext context) async {
                          final response = await deleteCustomer(customer.id.toString());
                          if (response.statusCode == 200) {
                            setState(() {
                              futureCustomers = getData();
                            });
                          } else {
                            // Handle error scenario
                            print('Failed to delete customer: ${response.body}');
                          }
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: buildCustomerListTile(customer),
                );
              },
            );

          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No customers found'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-customer');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Customer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_sharp),
            label: "Employees",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: "Menu",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildCustomerListTile(Customer customer) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: const Color(0xBD7F7FF3),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            customer.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(customer.email),
              Text(customer.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}
