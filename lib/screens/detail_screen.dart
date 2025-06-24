import 'package:flutter/material.dart';
import '../models/kitab.dart'; // ✅ pastikan file ini ada
import '../services/kitab_service.dart'; // ✅ pastikan file ini ada

class DetailScreen extends StatelessWidget {
  final Kitab kitab;

  const DetailScreen({super.key, required this.kitab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kitab.nama)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kategori: ${kitab.kategori}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Penulis: ${kitab.penulis}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
