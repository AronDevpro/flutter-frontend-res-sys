import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/features/core/screens/customer_Screen/customer_list.dart';
import 'package:flutter_frontend/src/features/core/screens/employee_screen/add_employee.dart';
import 'package:flutter_frontend/src/features/core/screens/customer_Screen/new_customer.dart';
import 'package:flutter_frontend/src/features/core/screens/employee_screen/employee_list.dart';
import 'package:flutter_frontend/src/features/core/screens/menu_screen/add_menu.dart';
import 'package:flutter_frontend/src/features/core/screens/menu_screen/menu_list.dart';
import 'package:flutter_frontend/src/features/core/screens/menu_screen/update_menu.dart';
import 'package:flutter_frontend/src/models/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Res Sys Project',
      initialRoute: '/',
      routes: {
        '/': (context) => const CustomerList(),
        '/add-customer': (context) => const NewCustomer(),
        '/employee': (context) => const EmployeeList(),
        '/add-employee': (context) => const AddEmployee(),
        '/menu': (context) => const MenuList(),
        '/add-menu': (context) => const AddMenu(),
      },
    );
  }
}

