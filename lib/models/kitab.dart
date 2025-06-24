class Kitab {
  final String id;
  final String nama;
  final String kategori;
  final String penulis;

  Kitab({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.penulis,
  });

  factory Kitab.fromJson(Map<String, dynamic> json) {
    return Kitab(
      id: json['id'].toString(),
      nama: json['nama'],
      kategori: json['kategori'],
      penulis: json['penulis'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'kategori': kategori,
        'penulis': penulis,
      };
}
