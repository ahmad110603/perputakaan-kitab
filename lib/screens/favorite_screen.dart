import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/hadith_service.dart';
import '../models/hadith_book.dart';
import 'hadith_list_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<HadithBook>> _favoriteBooks;

  @override
  void initState() {
    super.initState();
    _favoriteBooks = loadFavoriteBooks();
  }

  Future<List<HadithBook>> loadFavoriteBooks() async {
    final allBooks = await HadithService.getBooks();
    final favIds = await StorageService.getFavorites();
    return allBooks.where((book) => favIds.contains(book.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HadithBook>>(
      future: _favoriteBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Gagal memuat favorit: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Belum ada kitab favorit.'));
        }

        final books = snapshot.data!;
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              title: Text(book.name),
              onTap: () {
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
    );
  }
}
