import 'package:flutter/material.dart';

import 'const.dart';
import 'home_widgets.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          myAppBar(),
          SizedBox(height: 40),
          myImage(),
          SizedBox(height: 30),

          Text(
            "Ahmed Allam",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Flutter Developer",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
