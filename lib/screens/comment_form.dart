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
  AutovalidateMode validateMode = AutovalidateMode.disabled;
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
                autovalidateMode: validateMode,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a comment';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                "Cancel",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (commentFormKey.currentState!.validate()) {
                              } else {
                                setState(() {
                                  validateMode = AutovalidateMode.always;
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Style.violet,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                "Add",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
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
