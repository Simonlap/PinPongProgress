import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/pages/home_page.dart';
import 'package:mobile_application/pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _navBarItems;
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();

    _pages = [HomePage(), ProfilePage()];

    _navBarItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ];

    _controllers = List<AnimationController>.generate(_navBarItems.length, (int index) {
      return AnimationController(vsync: this, duration: Duration(milliseconds: 100))
        ..addListener(() => setState(() {}));
      }, growable: false);

    _controllers[_selectedIndex].value = 1.0;
  }

  void _navigateBottomBar(int index) {
    _controllers[_selectedIndex].reverse();
    _selectedIndex = index;
    _controllers[_selectedIndex].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Start',
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        backgroundColor: Color(0xFF294597), 
        selectedItemColor: Color(0xFFFFE019), 
        unselectedItemColor: Colors.grey, 
      ),
    );
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
