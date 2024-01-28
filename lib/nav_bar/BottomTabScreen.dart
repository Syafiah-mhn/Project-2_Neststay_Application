import 'package:flutter/material.dart';
import 'package:testpro2/nav_bar/FavouritePage.dart';
import 'package:testpro2/nav_bar/HistoryPage.dart';
import 'package:testpro2/nav_bar/HomePage.dart';
import 'package:testpro2/nav_bar/Profile/ProfilePage.dart';

class BottomTabScreen extends StatefulWidget {
  final String? username;

  const BottomTabScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.purple),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: _currentIndex == 0
              ? Text('Welcome, ${widget.username} !')
              : _getAppBarTitle(),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAppBarTitle() {
    // You can customize this based on the titles you want for other pages
    switch (_currentIndex) {
      case 1:
        return Text('Favourite Page');
      case 2:
        return Text('Booking Page');
      case 3:
        return Text('Profile Page');
      default:
        return Text('');
    }
  }
}
