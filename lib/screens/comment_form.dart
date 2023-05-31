import 'package:flutter/material.dart';
import '../components/style.dart';
import '../components/app_bar.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.violet,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomAppBar(title: 'Add Comment', icon: Icons.add_comment),
            ],
          ),
        ),
      ),
    );
  }
}
