import 'package:flutter/material.dart';
import '../models/hadith_book.dart';

class BookDetailScreen extends StatelessWidget {
  final HadithBook book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: const Color.fromARGB(255, 232, 230, 194),
      ),
      body: Center(
        child: Text(
          'Detail dari kitab: ${book.name}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
