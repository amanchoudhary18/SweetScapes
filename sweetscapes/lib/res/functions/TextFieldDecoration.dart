import 'package:flutter/material.dart';

class TextFieldDecoration {
  static BoxDecoration textFieldDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      border: Border.all(
        color: Colors.white,
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(
            0.0,
            5.0,
          ),
          blurRadius: 7.0,
          spreadRadius: 1.0,
        ), //BoxShadow
      ],
      color: Colors.white,
    );
  }
}
