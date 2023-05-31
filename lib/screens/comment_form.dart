import 'package:flutter/material.dart';
import '../components/style.dart';
import '../components/app_bar.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final commentFormKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

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
              const SizedBox(
                height: 20,
              ),
              Form(
                key: commentFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Style.violet,
                        ),
                        labelText: 'Comment',
                        prefixIcon: Icon(Icons.comment, color: Style.violet),
                        prefixIconColor: Style.violet,
                        border: Style.normal,
                        enabledBorder: Style.normal,
                        focusedBorder: Style.focused,
                        focusedErrorBorder: Style.errorFocused,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
