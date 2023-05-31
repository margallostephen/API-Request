import 'package:flutter/material.dart';
import 'style.dart';

abstract class Notif {
  static void showMessage(text, backgroundColor, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Style.violet,
        duration: const Duration(milliseconds: 1500),
        content: Card(
          color: backgroundColor,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons. info_outline_rounded,
                color: backgroundColor,
              ),
            ),
            title: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
