import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {

  const RoundedTextField({
    super.key,
    required this.text,
    required this.onChanged,
    this.obscureText = false,
  });

  final String text;
  final ValueChanged<String> onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: Color(0xffa5a2a0)),
      cursorColor: Colors.white,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(text),
        labelStyle: const TextStyle(color: Color(0xffa5a2a0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(1000)),
            borderSide: const BorderSide(
              color: Color(0xffa5a2a0),
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(1000)),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            )
        ),
      ),
    );
  }

}