import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/style.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  dynamic arguments;
  IconData? icon;
  bool titleChanged = false, bodyChanged = false;

  final taskFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(),
      bodyController = TextEditingController();

  String url = 'http://localhost:3000/posts';

  Future<http.Response> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'title': title,
          'body': body,
        },
      ),
    );

    return response;
  }

  Future<http.Response> updatePost(
      int postId, String title, String body) async {
    final response = await http.put(
      Uri.parse('$url/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': '$postId',
          'title': title,
          'body': body,
        },
      ),
    );

    return response;
  }

  Future<http.Response> partialUpdatePost(
      int postId, String data, String type) async {
    final response = await http.patch(
      Uri.parse('$url/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'id': '$postId',
          type: data,
        },
      ),
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments;
    arguments['operation'] == "Add Post" ? icon = Icons.add : icon = Icons.edit;

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
                key: taskFormKey,
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
                            if (value != arguments['name']) {
                              titleChanged = true;
                            } else {
                              titleChanged = false;
                            }
                          },
                        ),
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Style.violet,
                          ),
                          labelText: 'Title',
                          prefixIcon: Icon(Icons.topic, color: Style.violet),
                          prefixIconColor: Style.violet,
                          border: Style.normal,
                          enabledBorder: Style.normal,
                          focusedBorder: Style.focused,
                          focusedErrorBorder: Style.errorFocused,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a post title';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) => setState(
                          () {
                            if (value != arguments['body']) {
                              bodyChanged = true;
                            } else {
                              bodyChanged = false;
                            }
                          },
                        ),
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                            color: Style.violet,
                          ),
                          labelText: 'Body',
                          prefixIcon: Icon(Icons.article, color: Style.violet),
                          prefixIconColor: Style.violet,
                          border: Style.normal,
                          enabledBorder: Style.normal,
                          focusedBorder: Style.focused,
                          focusedErrorBorder: Style.errorFocused,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a post body';
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
                              onPressed: () {
                                if (taskFormKey.currentState!.validate()) {
                                  bool okayStatus = false;

                                  if (arguments['operation'] == 'Add Post') {
                                    createPost(
                                      titleController.text,
                                      bodyController.text,
                                    ).then(
                                      (value) {
                                        if (value.statusCode == 201) {
                                          okayStatus = true;
                                        }
                                      },
                                    );
                                  } else {
                                    if (titleChanged && bodyChanged) {
                                      updatePost(
                                        arguments['post_id'],
                                        titleController.text,
                                        bodyController.text,
                                      ).then(
                                        (value) {
                                          if (value.statusCode == 200) {
                                            okayStatus = true;
                                          }
                                        },
                                      );
                                    } else {
                                      String data = '', type = '';

                                      if (titleChanged) {
                                        data = titleController.text;
                                        type = 'title';
                                      } else {
                                        if (bodyChanged) {
                                          data = bodyController.text;
                                          type = 'body';
                                        }
                                      }

                                      partialUpdatePost(
                                        arguments['post_id'],
                                        data,
                                        type,
                                      ).then(
                                        (value) {
                                          if (value.statusCode == 200) {
                                            okayStatus = true;
                                          }
                                        },
                                      );
                                    }
                                  }

                                  if (okayStatus) {
                                    Navigator.pop(context);
                                  }
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
                                child: arguments['operation'] == 'Add Post'
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
