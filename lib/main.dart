import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/comments_screen.dart';
import 'screens/post_form.dart';
import 'screens/comment_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/post_list_screen',
      routes: {
        '/post_list_screen': (context) => const PostList(),
        '/post_detail_screen': (context) => const PostDetails(),
        '/comments_screen': (context) => const Comments(),
        '/post_form': (context) => const PostForm(),
        '/comment_form': (context) => const CommentForm(),
      },
    );
  }
}
