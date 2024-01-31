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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikedBookmarked();
  }

  final user = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool isBookmarked = false;
  final _commentTextController = TextEditingController();
  Future<void> toggleBookmark(String postId) async {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Threads').doc(postId);

    try {
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        bool isCurrentlyBookmarked = postSnapshot['isBookmarked'];

        // Print or use the current value as needed
        print('Current isBookmarked value: $isCurrentlyBookmarked');

        // Toggle the value
        postRef.update({
          'isBookmarked': !isCurrentlyBookmarked,
        });

        setState(() {
          isBookmarked = !isBookmarked;
        });

        // Print or use the updated value as needed
        print('Updated isBookmarked value: ${!isCurrentlyBookmarked}');
      } else {
        print('Post with ID $postId does not exist.');
      }
    } catch (e) {
      print('Error fetching/posting data: $e');
    }
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
    if (_commentTextController.text != '') {
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

  Future<void> getLikedBookmarked() async {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Threads').doc(widget.postId);

    try {
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        setState(() {
          isLiked = postSnapshot['likes'].contains(user.email);
          isBookmarked = postSnapshot['isBookmarked'];
        });
      } else {
        print('Post with ID ${widget.postId} does not exist.');
      }
    } catch (e) {
      print('Error fetching data: $e');
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
            Expanded(
              child: Container(
                child: Card(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Text(
                      widget.question,
                      style: TextStyle(fontSize: 36),
                    ),
                  )),
                ),
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
                    onPressed: () {
                      toggleBookmark(widget.postId);
                    },
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
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
