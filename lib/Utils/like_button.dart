import 'package:flutter/material.dart';

class Like_Button extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  Like_Button({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border_outlined,
        color: isLiked ? Colors.red : Colors.white,
      ),
      onPressed: onTap,
    );
  }
}
