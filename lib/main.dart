import 'package:flutter/material.dart';

import 'whatsApp/ui/whatsapp_chats_screen.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WhatsappChatsScreen(),
    );
  }
}
