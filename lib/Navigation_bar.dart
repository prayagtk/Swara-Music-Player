import 'package:flutter/material.dart';
import 'package:swara/screens/favorite_page.dart';
import 'package:swara/screens/home_page.dart';
import 'package:swara/screens/playlist.dart';
import 'package:swara/screens/settings.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentPage = 0;
  final screens = [HomePage(), Favorite_page(), PlayList(), Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade800,
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple.shade800,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30,
          currentIndex: currentPage,
          iconSize: 25,
          onTap: (index) => setState(() => currentPage = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Color.fromARGB(255, 116, 13, 160)),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
                backgroundColor: Color.fromARGB(255, 116, 13, 160)),
            BottomNavigationBarItem(
                icon: Icon(Icons.queue_music),
                label: 'Play List',
                backgroundColor: Color.fromARGB(255, 116, 13, 160)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Color.fromARGB(255, 116, 13, 160)),
          ]),
    );
  }
}
