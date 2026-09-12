import 'package:flutter/material.dart';

import 'bmi_calculator/bmi_calc_page.dart';
import 'counter_screen.dart';
import 'login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}
