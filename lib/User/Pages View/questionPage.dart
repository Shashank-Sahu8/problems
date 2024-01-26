import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Utils/comment.dart';
import 'package:project_power/Utils/like_button.dart';
import 'package:project_power/helper/helper_merthods.dart';

class questionPage extends StatefulWidget {
  final String question;
  final String user;
  final String postId;
  final List<String> likes;
  const questionPage(
      {super.key,
      required this.question,
      required this.user,
      required this.postId,
      required this.likes});

  @override
  State<questionPage> createState() => _questionPageState();
}

class _questionPageState extends State<questionPage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference ref =
        FirebaseFirestore.instance.collection('Threads').doc(widget.postId);
    if (isLiked) {
      ref.update({
        'likes': FieldValue.arrayUnion([user.email])
      });
    } else {
      ref.update({
        'likes': FieldValue.arrayRemove([user.email])
      });
    }
  }

  void addComment(String commentText) {
    if (commentText != '') {
      FirebaseFirestore.instance
          .collection('Threads')
          .doc(widget.postId)
          .collection('comments')
          .add({
        'CommentText': commentText,
        'CommentedBy': user.email,
        'CommentTime': Timestamp.now(),
      });
    }
  }

  void commentDialogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add Comment'),
              content: TextField(
                controller: _commentTextController,
                decoration: InputDecoration(hintText: 'Write a comment...'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentTextController.text;
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      addComment(_commentTextController.text);
                      _commentTextController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              height: 300,
              child: Card(
                child: Center(child: Text(widget.question)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Like_Button(isLiked: isLiked, onTap: toggleLike),
                    Text(
                      widget.likes.length.toString(),
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.teal,
                    ))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  commentDialogBox();
                },
                child: Text('Add a Comment')),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Threads')
                    .doc(widget.postId)
                    .collection('comments')
                    .orderBy('CommentTime')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      final commentData = doc.data() as Map<String, dynamic>;
                      return Comment(
                          comment: commentData['CommentText'],
                          user: commentData['CommentedBy'],
                          time: formatDate(commentData['CommentTime']));
                    }).toList(),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
