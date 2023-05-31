import 'package:flutter/material.dart';
import '../components/notif.dart';
import '../components/style.dart';
import '../components/app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  dynamic arguments;
  IconData? icon;
  int sateCount = 0;
  bool commentChanged = false;

  final commentFormKey = GlobalKey<FormState>();
  AutovalidateMode validateMode = AutovalidateMode.disabled;
  TextEditingController commentController = TextEditingController();

  String url = 'http://localhost:3000/comments';

  Future<http.Response> createPost(int id, String comment) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': '$id',
          'postId': '$id',
          'body': comment,
        },
      ),
    );

    return response;
  }

  Future<http.Response> updatePost(int id, String comment) async {
    final response = await http.put(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': '$id',
          'postId': '$id',
          'body': comment,
        },
      ),
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments;
    arguments['operation'] == "Add Comment"
        ? icon = Icons.add_comment
        : icon = Icons.edit_square;

    if (arguments['operation'] == "Edit Comment" && sateCount == 0) {
      commentController.text = arguments['comment'];
      sateCount++;
    }

    return Scaffold(
      backgroundColor: Style.violet,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomAppBar(title: arguments['operation'], icon: icon),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: commentFormKey,
                autovalidateMode: validateMode,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => setState(
                          () {
                            if (value != arguments['body']) {
                              commentChanged = true;
                            } else {
                              commentChanged = false;
                            }
                          },
                        ),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                              onPressed: () async {
                                if (commentFormKey.currentState!.validate()) {
                                  bool okayStatus = false;
                                  String message = '';
                                  Color backgroundColor = Colors.red;

                                  if (arguments['operation'] == 'Add Comment') {
                                    await createPost(
                                      arguments['post_id'],
                                      commentController.text,
                                    ).then(
                                      (value) {
                                        if (value.statusCode == 201) {
                                          okayStatus = true;
                                          message =
                                              'New comment added successfully';
                                          backgroundColor = Colors.green[600]!;
                                        }
                                      },
                                    );
                                  } else {
                                    if (commentChanged) {
                                      await updatePost(
                                        arguments['post_id'],
                                        commentController.text,
                                      ).then(
                                        (value) {
                                          if (value.statusCode == 200) {
                                            okayStatus = true;
                                            message =
                                                'Comment updated successfully';
                                            backgroundColor =
                                                Colors.green[600]!;
                                          }
                                        },
                                      );
                                    } else {
                                      if (!commentChanged) {
                                        okayStatus = true;
                                        message = 'No changes made';
                                      }
                                    }
                                  }

                                  if (okayStatus) {
                                    if (!mounted) return;
                                    Notif.showMessage(
                                      message,
                                      backgroundColor,
                                      context,
                                    );
                                    Navigator.pop(context);
                                  }
                                } else {
                                  setState(() {
                                    validateMode = AutovalidateMode.always;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Style.violet,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: arguments['operation'] == 'Add Comment'
                                    ? const Text(
                                        "Add",
                                        style: TextStyle(fontSize: 17),
                                      )
                                    : const Text(
                                        "Save",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
