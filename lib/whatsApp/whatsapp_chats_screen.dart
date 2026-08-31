import 'package:depi_five/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'whatsapp_text_styles.dart';

class WhatsappChatsScreen extends StatelessWidget {
  const WhatsappChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("WhatsApp", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
          Icon(CupertinoIcons.camera, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        child: Icon(Icons.message, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            _customChat(icon: Icons.lock, title: "Locked Chats"),
            _customChat(icon: Icons.archive, title: "Archive Chats", count: 6),

            Expanded(
              child: ListView.separated(
                itemCount: 40,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) => _myChat(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myChat() {
    return Row(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        CircleAvatar(radius: 25, backgroundImage: NetworkImage(image1)),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text("Mohamed", style: WhatsappTextStyles.titleTextStyle),
            Text("Hello from flutter", style: WhatsappTextStyles.msgTextStyle),
          ],
        ),
        Spacer(),
        Text("11:55 PM", style: WhatsappTextStyles.msgTextStyle),
      ],
    );
  }

  Widget _customChat({
    required IconData icon,
    required String title,
    int? count,
  }) {
    return Row(
      spacing: 20,
      children: [
        Icon(icon, color: Colors.green),
        Text(title, style: WhatsappTextStyles.titleTextStyle),
        if (count != null) ...[Spacer(), Text(count.toString())],
      ],
    );
  }
}
