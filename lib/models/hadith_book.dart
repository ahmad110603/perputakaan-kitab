class HadithBook {
  final String id;
  final String name;
  final bool available;

  HadithBook({
    required this.id,
    required this.name,
    required this.available,
  });

  /// Getter tambahan agar bisa dipanggil book.slug
  String get slug => id;

  factory HadithBook.fromJson(Map<String, dynamic> json) {
    return HadithBook(
      id: json['id'],
      name: json['name'],
      available: json['available'] == true,
    );
  }
}
