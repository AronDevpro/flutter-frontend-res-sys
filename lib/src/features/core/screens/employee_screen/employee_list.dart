import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/constants/server.dart';
import 'package:flutter_frontend/src/features/core/screens/employee_screen/update_employee.dart';
import 'package:flutter_frontend/src/models/employee.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late Future<List<Employee>> futureEmployees;

  Future<List<Employee>> getData() async {
    try {
      final response = await http.get(Uri.parse(API_EMPLOYEES));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Employee.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse('$API_EMPLOYEES/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          futureEmployees = getData();
        });
      } else {
        throw Exception('Failed to delete employee: ${response.body}');
      }
    } catch (e) {
      print('Failed to delete employee: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    futureEmployees = getData();
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
        title: const Text('Employee List'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees found'));
          } else {
            final employees = snapshot.data!;
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
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
                              builder: (context) => UpdateEmployee(employee: employee),
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
                          await deleteEmployee(employee.id.toString());
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: buildEmployeeListTile(employee),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-employee');
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

  Widget buildEmployeeListTile(Employee employee) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: const Color(0xBD7F7FF3),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            '${employee.firstName} ${employee.lastName}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.position),
              Text(employee.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }
}
