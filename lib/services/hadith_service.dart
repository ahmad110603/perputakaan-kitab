import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hadith_book.dart';

class HadithService {
  static const _baseUrl = 'https://api.hadith.gading.dev';

  // Ambil daftar kitab hadis (Bukhari, Muslim, dll)
  static Future<List<HadithBook>> getBooks() async {
    final response = await http.get(Uri.parse('$_baseUrl/books'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> dataList = jsonData['data'];
      return dataList.map((item) => HadithBook.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat daftar kitab');
    }
  }

  // Ambil daftar hadits dari kitab tertentu berdasarkan ID
  static Future<List<String>> getHadiths(String bookId,
      {String range = '1-10'}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/books/$bookId?range=$range'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> hadiths =
          jsonData['data']['hadiths']; // ✅ ambil dari key 'hadiths'

      return hadiths.map<String>((item) {
        return item['arab'] as String; // atau item['id'] untuk versi Indonesia
      }).toList();
    } else {
      throw Exception('Gagal memuat hadits dari $bookId');
    }
  }
}
// Catatan: Pastikan untuk menambahkan dependensi http di pubspec.yaml
