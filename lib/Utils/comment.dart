import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Comment extends StatefulWidget {
  final String comment;
  final String user;
  final String time;
  const Comment(
      {super.key,
      required this.comment,
      required this.user,
      required this.time});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey[500]),
      child: Column(
        children: [
          Text(widget.comment),
          Row(
            children: [
              Text(widget.user),
              Text(' . '),
              Text(widget.time),
            ],
          )
        ],
      ),
    );
  }
}
