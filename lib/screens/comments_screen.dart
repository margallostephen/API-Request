import 'package:api_request/components/style.dart';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  int id = 0;
  List<dynamic> _comments = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData(id);
    });
  }

  Future<void> fetchData(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/posts/$id/comments'));
    if (response.statusCode == 200) {
      setState(() {
        _comments = jsonDecode(response.body);
      });
    }
  }

  Future<void> deleteComment(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:3000/comments/$id'));
    if (response.statusCode == 200) {
      fetchData(id);
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
            CustomAppBar(title: 'Comments', icon: Icons.comment),
            Expanded(
              child: Container(
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
                child: _comments.isEmpty
                    ? const Center(
                        child: Text(
                          'No Comment Yet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          final comment = _comments[index];

                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(comment['id'].toString()),
                            onDismissed: (_) {
                              deleteComment(comment['id']);
                            },
                            background: Container(
                              margin: const EdgeInsets.fromLTRB(
                                5,
                                5,
                                5,
                                10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red,
                              ),
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.fromLTRB(
                                5,
                                5,
                                5,
                                10,
                              ),
                              elevation: 10,
                              shadowColor: Colors.black,
                              child: ListTile(
                                title: Text(
                                  comment['body'],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/comment_screen',
                                      arguments: {
                                        'post_id': id,
                                        'operation': 'Edit Comment'
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Style.violet,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
