import 'package:flutter/material.dart';

import 'my_home.dart';

void main() {
  runApp(const MyApp());
}

/// MaterialApp (home)
/// Scaffold ( appbar , body)
/// Container()
/// SizedBox()
/// Column()
/// Row()
/// CircleAvatar()
/// Icon(Icons.)
/// NetworkImage
/// Divider()
/// Padding()
/// Text()

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHome());
  }
}
