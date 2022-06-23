import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? error;
  const CustomTextField({
    Key? key,
    this.controller,
    this.label,
    this.error,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = widget.controller?.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text!.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length <= 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: widget.controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),

        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
        hintStyle: TextStyle(color: Colors.white70),
        hintText: widget.label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        border: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
