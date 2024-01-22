import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Utils/commentButton.dart';
import 'package:project_power/Utils/like_button.dart';

class newCommunityPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const newCommunityPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<newCommunityPost> createState() => _newCommunityPostState();
}

class _newCommunityPostState extends State<newCommunityPost> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    isLiked = widget.likes.contains(user.email);
  }

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
    return InkWell(
      onDoubleTap: toggleLike,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey[800], fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.message,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Like_Button(
                        isLiked: isLiked,
                        onTap: () {
                          toggleLike();
                        }),
                    Text(widget.likes.length.toString())
                  ],
                ),
                CommentButton(
                  onTap: () {
                    commentDialogBox();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
