import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_power/Chats/Chat.dart';

import 'ai_call1.dart';

class ChatInboxPage extends StatefulWidget {
  const ChatInboxPage({Key? key}) : super(key: key);

  @override
  State<ChatInboxPage> createState() => _ChatInboxPageState();
}

class _ChatInboxPageState extends State<ChatInboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      )),
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.tertiary,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => bot()));
                },
                title: Text(
                  'Medi bot',
                  style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.wb_incandescent_rounded,
                  color: Colors.red,
                ),
              ),
            ),
            //Divider(),
            _buildInbox(),
          ],
        ),
      ),
    );
  }

  Widget _buildInbox() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc('details')
          .collection('data')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return _buildUserListItem(doc);
            },
          ),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Don't display the current user in the list
    if (FirebaseAuth.instance.currentUser!.email != data['email'] &&
        data['check'] == true) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.tertiary),
          child: ListTile(
            title: Text(
              "Dr.  " + data['name'],
              style: GoogleFonts.acme(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => chat_page(
                    recieverEmail: data['name'],
                    recieverUserId: data['id'],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return Container();
  }
}
