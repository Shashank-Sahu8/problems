import 'package:flutter/material.dart';

class myTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const myTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  State<myTextField> createState() => _myTextFieldState();
}

class _myTextFieldState extends State<myTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(hintText: widget.hintText),
      ),
    );
  }
}
