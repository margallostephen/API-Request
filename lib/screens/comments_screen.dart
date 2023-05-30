import 'package:flutter/material.dart';
import '../components/app_bar.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 23, 94),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(title: 'Comments', icon: Icons.comment),
          ],
        ),
      ),
    );
  }
}
