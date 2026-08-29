import 'package:flutter/material.dart';

import 'const.dart';
import 'home_widgets.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      body: Container(color: Colors.red),
      bottomNavigationBar: Container(height: 200, color: Colors.blue),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
   
    );
  }
}
