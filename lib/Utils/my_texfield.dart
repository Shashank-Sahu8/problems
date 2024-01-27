import 'package:flutter/material.dart';

class myTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  void Function()? onTap;

  myTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  State<myTextField> createState() => _myTextFieldState();
}

class _myTextFieldState extends State<myTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(color: Colors.black), // Set text color to black
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: widget.hintText,
          suffixIconColor: Theme.of(context).colorScheme.primary,

          // Set background color of the text field
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: widget.onTap, icon: widget.icon),
          ),
        ),
      ),
    );
  }
}
