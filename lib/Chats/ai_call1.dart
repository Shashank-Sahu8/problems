import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class bot extends StatefulWidget {
  const bot({super.key});

  @override
  State<bot> createState() => _botState();
}

class _botState extends State<bot> {
  ChatUser me = ChatUser(id: '1', firstName: 'user');
  ChatUser bot = ChatUser(id: '2', firstName: 'Gemini');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  final url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBRZCjp1rPZuXUweF9ikVYknAofX6dj-j0";

  final header = {'Content-Type': 'application/json'};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatMessage m1 = ChatMessage(
        user: bot, createdAt: DateTime.now(), text: 'Hey! how can I help you');
    allMessages.insert(0, m1);
    setState(() {});
  }

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(url), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        // print(result['candidates'][0]['content']['parts'][0]['text']);
        ChatMessage mm = ChatMessage(
            user: bot,
            createdAt: DateTime.now(),
            text: result['candidates'][0]['content']['parts'][0]['text']);
        allMessages.insert(0, mm);
        setState(() {});
      } else
        print("error");
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        typingUsers: typing,
        currentUser: me,
        onSend: (ChatMessage m) {
          getdata(m);
        },
        messages: allMessages,
      ),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: Text(
          "MediBot",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        automaticallyImplyLeading: true,
      ),
    );
  }
}

// curl \
// -H 'Content-Type: application/json' \
// -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
// -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY
