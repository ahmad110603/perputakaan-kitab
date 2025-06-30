import 'package:flutter/material.dart';
import '../models/hadith_book.dart';
import '../services/hadith_service.dart';
import 'hadith_list_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});
  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<HadithBook>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = HadithService.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kitab Hadits')),
      body: FutureBuilder<List<HadithBook>>(
        future: futureBooks,
        builder: (ctx, snap) {
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snap.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (_, i) {
              final book = books[i];
              return ListTile(
                title: Text(book.name),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HadithListScreen(book: book),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
