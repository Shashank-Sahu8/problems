import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.fromLTRB(25, 25, 25, 0),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            children: [Like_Button(isLiked: true, onTap: () {}), Text('1')],
          ),
          Column(
            children: [
              Text(widget.message,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[800], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
