import 'package:flutter/material.dart';
import 'package:explorer_web/pages/dashboard_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardPage(), // Page 1
    Center(child: Text('Chats')), // Page 2
    Center(child: Text('Groups')), // Page 3
    Center(child: Text('Settings')), // Page 4
    Center(child: Text('Profile')), // Page 5
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: _selectedIndex, // Highlight the selected item
        selectedItemColor: const Color.fromARGB(255, 51, 31, 215), // Selected color
        unselectedItemColor: Colors.grey, // Unselected color
        onTap: _onItemTapped, // Handle item tap
        showSelectedLabels: false, // No labels for selected item
        showUnselectedLabels: false, // No labels for unselected items
        type: BottomNavigationBarType.fixed, // Fixed to avoid shifting behavior
      ),
    );
  }
}
