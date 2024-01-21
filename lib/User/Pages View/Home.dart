import 'package:flutter/material.dart';
import 'package:project_power/Chats/chat_inbox_page.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ChatInboxPage()));
              },
              icon: Icon(Icons.chat_bubble))
        ],
      ),
    );
  }
}
