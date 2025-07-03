import 'package:flutter/material.dart';
import 'screens/book_list_screen.dart'; // Home
import 'screens/last_read_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kumpulan Kitab Hadits',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    BookListScreen(), // Beranda
    LastReadScreen(), // Terakhir dibaca
    FavoriteScreen(), // Favorit
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // ⬅️ Teks ditengah
        title: const Text(
          'Kumpulan Kitab Hadits',
          style: TextStyle(
            fontWeight: FontWeight.bold, // ⬅️ Dicetak tebal
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 232, 230, 194),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Terakhir Dibaca'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        ],
      ),
    );
  }
}
