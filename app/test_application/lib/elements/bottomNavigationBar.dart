import 'package:flutter/material.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/profile.dart';
import 'package:test_application/screens/start.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final BuildContext context;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.context, this.onTap = _defaultOnTap});

  // Default onTap method
  static void _defaultOnTap(int index) {
    // Do nothing by default
  }

  // Standard onTap method for the home item
  void _onHomeTap() {
    onTap(0);
    Navigator.pushAndRemoveUntil(
      context,
      CustomPageRouteBuilder.slideInFromLeft(const Start()),
      (route) => false
    );
  }

  // Standard onTap method for the person item
  void _onPersonTap() {
    onTap(1);
    // Use PageRouteBuilder for custom page transition to the Profile page
    Navigator.pushAndRemoveUntil(
      context,
      CustomPageRouteBuilder.slideInFromRight(const Profile()),
      (route) => false
    );
  }

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
      onTap: (index) {
        // Call the appropriate standard onTap method based on the index
        if (index == 0) {
          _onHomeTap();
        } else if (index == 1) {
          _onPersonTap();
        }
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
