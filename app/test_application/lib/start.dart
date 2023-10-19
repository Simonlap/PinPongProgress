import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Start'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the mini-game page
              },
              child: const Text('Minispiele starten'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the general stats page
              },
              child: const Text('Statistiken anschauen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the edit players page
              },
              child: const Text('Spieler verwalten'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: 0, // Index of the current tab (Start in this case)
          onTap: (int index) {
            // Handle tab changes here (e.g., navigate to the profile page)
          },
          showSelectedLabels: false, // Hide labels for selected tab
          showUnselectedLabels: false, // Hide labels for unselected tabs
        ));
  }
}
