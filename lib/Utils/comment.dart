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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey, fontSize: 8),
                  ),
                  Text(' . ',
                      style: TextStyle(color: Colors.grey, fontSize: 8)),
                  Text(widget.time,
                      style: TextStyle(color: Colors.grey, fontSize: 8)),
                ],
              ),
              Text(widget.comment,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
