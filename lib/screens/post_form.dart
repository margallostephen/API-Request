import 'package:flutter/cupertino.dart';
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

  final taskFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
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
                              onPressed: () {},
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
                              onPressed: () {},
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
