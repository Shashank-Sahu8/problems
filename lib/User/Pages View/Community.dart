import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Utils/comm_post.dart';
import 'package:project_power/Utils/my_texfield.dart';
import 'package:project_power/helper/helper_merthods.dart';

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
    'isBookmarked': false,
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
                    style: TextStyle(fontSize: 24, color: Colors.teal),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: myTextField(
                      icon: Icon(Icons.arrow_downward),
                      controller: postController,
                      onTap: () {
                        postMessage();
                        postController.clear();
                      },
                      hintText: 'Add new Thread',
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Threads')
                        .orderBy('Timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final thread = snapshot.data!.docs[index];
                            return newCommunityPost(
                              message: thread['question'],
                              user: thread['userEmail'],
                              time: formatDate(thread['Timestamp']),
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
