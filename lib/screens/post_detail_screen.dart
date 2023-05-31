import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/app_bar.dart';
import '../components/style.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  int id = 0;
  dynamic _post = {};
  String title = "", body = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(id);
    });
  }

  Future<void> fetchData(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/posts/$id'));
    if (response.statusCode == 200) {
      setState(() {
        _post = jsonDecode(response.body);
        title = _post['title'];
        body = _post['body'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments as dynamic;
    id = args['post_id'];

    return Scaffold(
      backgroundColor: Style.violet,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(title: 'Post Details', icon: Icons.chat_bubble),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 20,
              ),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        body,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/comments_screen',
                            arguments: {
                              'post_id': id,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.violet,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            'View Comments',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
