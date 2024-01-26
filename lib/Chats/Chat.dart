import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Chats/chat_service.dart';

class chat_page extends StatefulWidget {
  final recieverEmail;
  final recieverUserId;
  const chat_page(
      {super.key, required this.recieverEmail, required this.recieverUserId});

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserId, _messageController.text);

      _messageController.clear();
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;

        // Use the file (for example, print its path)
        print('File picked: ${file.path}');
      } else {
        // User canceled the picker
        print('User canceled the file picker.');
      }
    } catch (e) {
      // Handle any errors that might occur during file picking
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recieverEmail)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput()
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.recieverUserId, _firebaseAuth.currentUser!.uid),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var isSender = (data['senderId'] == _firebaseAuth.currentUser!.uid);

    return Container(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: isSender
            ? Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['message'],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.recieverEmail),
                  Card(
                    color: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['message'],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ));
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Type your message'),
              controller: _messageController,
            ),
          ),
          IconButton(
            onPressed: () {
              pickFile();
            },
            icon: const Icon(Icons.attach_file),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
              onPressed: () {
                sendMessage();
                print(FirebaseAuth.instance.currentUser!.uid);
                // print(object)
              },
              icon: CircleAvatar(
                child: Icon(Icons.send),
              ))
        ],
      ),
    );
  }
}
