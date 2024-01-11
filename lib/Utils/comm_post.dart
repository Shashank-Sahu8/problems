import 'package:flutter/material.dart';

class newCommunityPost extends StatefulWidget {
  final String message;
  final String user;
  const newCommunityPost({
    super.key,
    required this.message,
    required this.user,
  });

  @override
  State<newCommunityPost> createState() => _newCommunityPostState();
}

class _newCommunityPostState extends State<newCommunityPost> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(widget.user),
            Text(widget.message),
          ],
        ),
      ],
    );
  }
}
