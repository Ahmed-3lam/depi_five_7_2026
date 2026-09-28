import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/note_app/view/note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.openBox("Box1");
  await Hive.openBox(HiveHelper.noteBox);

  /// Put
  // Hive.box("Box1").put("key1", "Ahmed");
  // print(Hive.box("Box1").get("key1"));

  /// Get
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: NotePage());
  }
}
