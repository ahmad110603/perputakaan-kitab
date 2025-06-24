import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kitab.dart';

class KitabService {
  static const String baseUrl = 'http://10.0.2.2:3000/kitab'; // Emulator

  static Future<List<Kitab>> ambilSemuaKitab() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Kitab.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat kitab');
    }
  }

  static Future<void> tambahKitab(
      String nama, String kategori, String penulis) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'nama': nama, 'kategori': kategori, 'penulis': penulis}),
    );
    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan kitab');
    }
  }

  static Future<void> editKitab(
      String id, String nama, String kategori, String penulis) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'nama': nama, 'kategori': kategori, 'penulis': penulis}),
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal mengedit kitab');
    }
  }

  static Future<void> hapusKitab(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus kitab');
    }
  }
}
