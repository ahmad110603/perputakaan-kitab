// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart'; // Ganti jika nama file kamu beda

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman utama setelah 2 detik
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 230, 194),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 80, color: Colors.brown),
            SizedBox(height: 20),
            Text(
              'Kumpulan Kitab Hadits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
