import 'package:flutter/material.dart';

abstract class Style {
  // App default color
  static const violet = Color.fromARGB(255, 54, 23, 94);

  // Text Form Field Style
  static const normal = OutlineInputBorder(
    borderSide: BorderSide(
      color: violet,
    ),
  );
  
  static const focused = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide(
      width: 2,
      color: violet,
    ),
  );

  static const errorFocused = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
    borderSide: BorderSide(
      width: 2,
      color: Colors.red,
    ),
  );
}
