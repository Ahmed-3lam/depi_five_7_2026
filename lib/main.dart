
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/splash/splash_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.onBoardingBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashPage(),
    );
  }
}

