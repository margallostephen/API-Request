import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/app_bar.dart';
import '../components/style.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/posts'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = jsonDecode(response.body);
      });
    }
  }

  // delete post
  Future<void> deletePost(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:3000/posts/$id'));
    if (response.statusCode == 200) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.violet,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomAppBar(
              title: 'Posts',
              icon: Icons.forum,
            ),
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
                child: _posts.isEmpty
                    ? const Center(
                        child: Text(
                          'No Post Yet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: (context, index) {
                          final post = _posts[index];
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(post['id'].toString()),
                            onDismissed: (_) {
                              deletePost(post['id']);
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/post_detail_screen',
                                    arguments: {
                                      'post_id': post['id'],
                                    },
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    post['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(post['body']),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      await Navigator.pushNamed(
                                        context,
                                        '/post_form',
                                        arguments: {
                                          'post_id': post['id'],
                                          'operation': 'Edit Post',
                                          'title': post['title'],
                                          'body': post['body'],
                                        },
                                      );

                                      fetchData();
                                    },
                                    child: const Icon(
                                      Icons.edit_square,
                                      color: Style.violet,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      '/post_form',
                      arguments: {
                        'post_id': 0,
                        'operation': 'Add Post',
                        'title': '',
                        'body': '',
                      },
                    );

                    fetchData();
                  },
                  child: const Icon(
                    Icons.add,
                    color: Style.violet,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
