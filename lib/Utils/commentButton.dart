import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  final void Function()? onTap;
  const CommentButton({super.key, this.onTap});

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Icon(Icons.comment),
    );
  }
}
