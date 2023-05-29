import 'package:flutter/material.dart';
import 'style.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  String title;
  dynamic icon;
  CustomAppBar({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Icon(
              icon,
              color: Style.violet,
              size: 30,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Style.violet,
            ),
          ),
        ],
      ),
    );
  }
}
