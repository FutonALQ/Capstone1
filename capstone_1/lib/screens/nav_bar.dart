import 'package:capstone_1/screens/following_screen.dart';
import 'package:capstone_1/screens/home_screen.dart';
import 'package:capstone_1/screens/profile_screen.dart';
import 'package:capstone_1/screens/search_screen.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  List screensList = [
    UserProfile(),
    SearchScreen(),
    TripListScreen(),
    const HomeScreen(),
  ];

  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[selected],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: Colors.grey,
          unselectedItemColor: const Color.fromARGB(92, 0, 0, 0),
          currentIndex: selected,
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          ]),
    );
  }
}
