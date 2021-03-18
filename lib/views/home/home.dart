import 'package:flutter/material.dart';
import 'package:flutter_login/views/feed/bucket.dart';
import 'package:flutter_login/views/profile/profile.dart';

class Home extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Home());
  }

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Feed(), Profile(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Main test'),
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
