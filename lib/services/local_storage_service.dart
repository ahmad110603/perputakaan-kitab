import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /// Menyimpan ID kitab terakhir dibaca
  static Future<void> setLastRead(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_read', bookId);
  }

  /// Mengambil ID kitab terakhir dibaca
  static Future<String?> getLastRead() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_read');
  }

  /// Menambahkan favorit
  static Future<void> addFavorite(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(bookId)) {
      favorites.add(bookId);
      await prefs.setStringList('favorites', favorites);
    }
  }

  /// Menghapus favorit
  static Future<void> removeFavorite(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(bookId);
    await prefs.setStringList('favorites', favorites);
  }

  /// Mendapatkan daftar ID kitab favorit
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  /// ✅ Fungsi untuk toggle favorit (tambahkan atau hapus jika sudah ada)
  static Future<void> toggleFavorite(String bookId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (favorites.contains(bookId)) {
      favorites.remove(bookId);
    } else {
      favorites.add(bookId);
    }
    await prefs.setStringList('favorites', favorites);
  }
}
