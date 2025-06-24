import 'package:flutter/material.dart';
import '../models/kitab.dart';
import '../services/kitab_service.dart';

class FormScreen extends StatefulWidget {
  final Kitab? kitab;

  const FormScreen({super.key, this.kitab});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _penulisController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.kitab?.nama ?? '');
    _kategoriController =
        TextEditingController(text: widget.kitab?.kategori ?? '');
    _penulisController =
        TextEditingController(text: widget.kitab?.penulis ?? '');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text;
      final kategori = _kategoriController.text;
      final penulis = _penulisController.text;

      try {
        if (widget.kitab == null) {
          // Tambah
          await KitabService.tambahKitab(nama, kategori, penulis);
        } else {
          // Edit
          await KitabService.editKitab(
              widget.kitab!.id, nama, kategori, penulis);
        }
        if (context.mounted)
          Navigator.pop(context, true); // Kembali ke halaman sebelumnya
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal menyimpan data')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.kitab != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Kitab' : 'Tambah Kitab')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Kitab'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(labelText: 'Penulis'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Harus diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah Kitab'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
