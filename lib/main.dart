import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart';
import 'screens/post_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/post_list_screen',
      routes: {
        '/post_list_screen': (context) => const PostList(),
        '/post_detail_screen': (context) => const PostDetails(),
      },
    );
  }
}
