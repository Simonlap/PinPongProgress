import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '', // Empty string for no label
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '', // Empty string for no label
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
