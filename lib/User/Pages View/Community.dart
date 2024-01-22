import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Utils/comm_post.dart';
import 'package:project_power/Utils/my_texfield.dart';

class community extends StatefulWidget {
  const community({super.key});

  @override
  State<community> createState() => _communityState();
}

final postController = TextEditingController();
void postMessage() async {
  await FirebaseFirestore.instance.collection('Threads').add({
    'userEmail': FirebaseAuth.instance.currentUser!.email,
    'question': postController.text.toString(),
    'Timestamp': Timestamp.now(),
    'likes': [],
  });
}

class _communityState extends State<community> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Community',
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: myTextField(
                          controller: postController,
                          hintText: 'Add new Thread',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          postMessage();
                          postController.clear();
                          // Clear text field after posting
                        },
                        icon: CircleAvatar(
                          child: Icon(Icons.arrow_upward),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Threads')
                        .orderBy('Timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final thread = snapshot.data!.docs[index];
                            return newCommunityPost(
                              message: thread['question'],
                              user: thread['userEmail'],
                              postId: thread.id,
                              likes: List<String>.from(thread['likes'] ?? []),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error'),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
