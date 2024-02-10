import 'package:flutter/material.dart';
import 'package:project_power/Chats/chat_inbox_page.dart';
import 'package:random_avatar/random_avatar.dart';

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
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: CircleAvatar(
              radius: 18.5,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: RandomAvatar(
                DateTime.now().toIso8601String(),
                height: 35,
                width: 35,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ChatInboxPage()));
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                child: Icon(
                  Icons.message_outlined,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ))
        ],
      ),
    );
  }
}
