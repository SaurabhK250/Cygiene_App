import 'package:cygiene_ui/cyber_tips_view.dart';
import 'package:cygiene_ui/home_view.dart';
import 'package:cygiene_ui/views/profile_pages/about_us_view.dart';
import 'package:cygiene_ui/views/profile_pages/blogs_view.dart';
import 'package:cygiene_ui/views/profile_pages/faqs_view.dart';
import 'package:cygiene_ui/views/profile_pages/profile_view.dart';

import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> screens = [
    const HomeView(),
    NewsListScreen(),
    const ProfileView(),
    const AboutUsView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
       bottomNavigationBar: BottomNavigationBar(
       
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
          
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
         backgroundColor: Colors.red,
         selectedLabelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}

