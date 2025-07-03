import 'package:flutter/material.dart';
import '../models/hadith_book.dart';
import '../services/hadith_service.dart';
import '../services/local_storage_service.dart';
import 'hadith_list_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<HadithBook>> futureBooks;
  List<String> favoriteIds = [];

  @override
  void initState() {
    super.initState();
    futureBooks = HadithService.getBooks();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final ids = await StorageService.getFavorites();
    setState(() {
      favoriteIds = ids;
    });
  }

  Future<void> _toggleFavorite(String bookId) async {
    await StorageService.toggleFavorite(bookId);
    _loadFavorites(); // refresh favorites
  }

  bool _isFavorite(String bookId) {
    return favoriteIds.contains(bookId);
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
              final isFavorite = _isFavorite(book.id);

              return ListTile(
                title: Text(book.name),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => _toggleFavorite(book.id),
                ),
                onTap: () async {
                  await StorageService.setLastRead(book.id);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HadithListScreen(book: book),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
