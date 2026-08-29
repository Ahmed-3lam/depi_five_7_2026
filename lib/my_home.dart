import 'package:flutter/material.dart';

import 'const.dart';
import 'home_widgets.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(Icons.menu, color: Colors.white),
        title: Text("My AppBar", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.edit, color: Colors.white),
          SizedBox(width: 20),
        ],
     
     
      ),
    );
  }
}
