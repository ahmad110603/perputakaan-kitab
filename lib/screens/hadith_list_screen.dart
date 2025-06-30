import 'package:flutter/material.dart';
import '../models/hadith_book.dart';
import '../services/hadith_service.dart';

class HadithListScreen extends StatefulWidget {
  final HadithBook book;
  const HadithListScreen({super.key, required this.book});
  @override
  State<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends State<HadithListScreen> {
  late Future<List<String>> futureHadiths;

  @override
  void initState() {
    super.initState();
    futureHadiths = HadithService.getHadiths(widget.book.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.name)),
      body: FutureBuilder<List<String>>(
        future: futureHadiths,
        builder: (ctx, snap) {
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final list = snap.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) => ListTile(
              title: Text('Hadith ${i + 1}'),
              subtitle: Text(list[i]),
            ),
          );
        },
      ),
    );
  }
}
