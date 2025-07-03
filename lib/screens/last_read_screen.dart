import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../services/hadith_service.dart';
import '../models/hadith_book.dart';
import 'book_detail_screen.dart'; // Pastikan file ini ada

class LastReadScreen extends StatefulWidget {
  const LastReadScreen({super.key});

  @override
  State<LastReadScreen> createState() => _LastReadScreenState();
}

class _LastReadScreenState extends State<LastReadScreen> {
  HadithBook? _lastReadBook;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadLastRead();
  }

  Future<void> loadLastRead() async {
    final bookId = await StorageService.getLastRead();
    if (bookId != null) {
      try {
        final books = await HadithService.getBooks();
        final book = books.firstWhere((b) => b.id == bookId);
        setState(() {
          _lastReadBook = book;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _lastReadBook = null;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _lastReadBook = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_lastReadBook == null) {
      return const Center(child: Text('Belum ada kitab yang dibaca.'));
    }

    return ListTile(
      title: Center(
        child: Text(
          _lastReadBook!.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      subtitle: Center(child: Text('Kitab terakhir yang kamu buka')),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailScreen(book: _lastReadBook!),
          ),
        );
      },
    );
  }
}
