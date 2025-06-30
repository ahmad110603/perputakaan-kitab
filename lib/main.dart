import 'package:flutter/material.dart';
import 'screens/book_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hadith API App',
      home: const BookListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
