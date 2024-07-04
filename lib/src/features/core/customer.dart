import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomerView extends StatelessWidget {

  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: Slidable(
        child: SizedBox(
          height: 100,
          child: Card(
            color: Colors.amber,
            margin: const EdgeInsets.all(10),
            child:Column(
              children: [
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                        Text("Customer Name", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        Text("E-mail"),
                        Text("Phone Number"),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: ()
                        {Navigator.pushNamed(context, '/add-customer');},
                        icon: Icon(Icons.delete, size: 30,)
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, '/add-customer');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
