import 'package:flutter/material.dart';

import 'my_home.dart';

void main() {
  runApp(const MyApp());
}

/// MaterialApp (home)
/// Scaffold ( body)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}
