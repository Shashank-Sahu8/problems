import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project_power/User/Pages%20View/questionPage.dart';
import 'package:project_power/Utils/comment.dart';
import 'package:project_power/Utils/commentButton.dart';
import 'package:project_power/Utils/like_button.dart';
import 'package:project_power/helper/helper_merthods.dart';

class newCommunityPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;
  const newCommunityPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
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

  OverlayEntry? _overlayEntry;
  void _showLikeOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    // Get the center of the post container
    double centerX = position.dx + renderBox.size.width / 2;
    double centerY = position.dy + renderBox.size.height / 2;

    // Create an OverlayEntry to show the filled heart icon
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: centerY - 30, // Adjust as needed
        left: centerX - 30, // Adjust as needed
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 300), // Adjust duration as needed
          tween: Tween<double>(begin: 0.5, end: 1.0), // Opacity tween
          builder: (context, opacity, child) {
            return TweenAnimationBuilder(
              duration:
                  Duration(milliseconds: 300), // Adjust duration as needed
              tween: Tween<double>(begin: 0.7, end: 1.0), // Scale tween
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );

    // Insert the OverlayEntry into the Overlay
    Overlay.of(context).insert(_overlayEntry!);

    // Schedule a timer to remove the overlay after 2 seconds
    Timer(Duration(seconds: 1), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        if (isLiked == false) {
          toggleLike();
        }
        _showLikeOverlay();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => questionPage(
                    question: widget.message,
                    user: widget.user,
                    postId: widget.postId,
                    likes: widget.likes)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 20)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(widget.user,
                        style: TextStyle(
                          fontSize: 8,
                        )),
                    Text(' . '),
                    Text(widget.time,
                        style: TextStyle(
                          fontSize: 8,
                        )),
                  ],
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Threads')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy('CommentTime')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                // Store the snapshot in a variable
                var commentsSnapshot = snapshot.data!;

                return Column(
                  children: [
                    // Your existing code...

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Like_Button(
                            isLiked: isLiked,
                            onTap: () {
                              toggleLike();
                            }),
                        Text(widget.likes.length.toString()),
                        CommentButton(
                          onTap: () {
                            commentDialogBox();
                          },
                        ),
                        Text(commentsSnapshot.docs.length.toString())
                      ],
                    ),

                    // Your existing code...
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
