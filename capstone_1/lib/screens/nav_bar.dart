import 'package:capstone_1/screens/following_screen.dart';
import 'package:capstone_1/screens/home_screen.dart';
import 'package:capstone_1/screens/profile_screen.dart';
import 'package:capstone_1/screens/search_screen.dart';
import 'package:capstone_1/screens/users_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  // List screensList = [
  //   UserProfile(),
  //   SearchScreen(),
  //   TripListScreen(),
  //   const HomeScreen(),
  // ];

  List screensList = [
    const HomeScreen(),
    const TripListScreen(),
    SearchScreen(),
    ProfileScreen(),
    UsersScreen(),
  ];

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[selected],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selected,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          selected = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: const Color(0xff219EBC),
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xff219EBC),
            icon: const Icon(Icons.people),
            title: const Text('Trips'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xff219EBC),
            icon: const Icon(Icons.search),
            title: const Text('Search'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xff219EBC),
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
          FlashyTabBarItem(
            activeColor: const Color(0xff219EBC),
            icon: const Icon(Icons.chat_bubble_outline_sharp),
            title: const Text('chat'),
          ),
        ],
      ),
    );
  }
}
