import 'package:depi_five/whatsApp/const/const.dart';
import 'package:depi_five/whatsApp/api_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../const/whatsapp_text_styles.dart';

class WhatsappChatsScreen extends StatelessWidget {
  const WhatsappChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = apiChats.map((e) => ChatModel.fromJson(e)).toList();
    return Scaffold(
      appBar: _appBar(),
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
            // for(int i = 0 ; i<chats.length ;i++)
            Expanded(
              child: ListView.separated(
                itemCount: chats.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, i) => _myChat(chats[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
    );
  }

  Widget _myChat(ChatModel chat) {
    return Row(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(chat.image ?? ""),
        ),
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(chat.name ?? "", style: WhatsappTextStyles.titleTextStyle),

            _messageBuilder(chat),
          ],
        ),
        Spacer(),
        Text(chat.time ?? "", style: WhatsappTextStyles.msgTextStyle),
      ],
    );
  }

  Widget _messageBuilder(ChatModel chat) {
    if (chat.messageType == ChatType.text) {
      return Text(chat.message ?? "", style: WhatsappTextStyles.msgTextStyle);
    } else if (chat.messageType == ChatType.video) {
      return Row(
        children: [
          Icon(CupertinoIcons.video_camera),
          Text("Video", style: WhatsappTextStyles.msgTextStyle),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.gif),
          Text("Gif", style: WhatsappTextStyles.msgTextStyle),
        ],
      );
    }
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
