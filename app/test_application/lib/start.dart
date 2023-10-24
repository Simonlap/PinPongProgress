import 'package:flutter/material.dart';
import 'package:test_application/bottomNavigationBar.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/profile.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Start',
          style: TextStyle(fontSize: 24), // Adjust the font size here
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 50)), // Set the button's height
                      ),
                      onPressed: () {
                        // Navigate to the mini-game page
                      },
                      child: const Text('Minispiele starten'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 50)), // Set the button's height
                      ),
                      onPressed: () {
                        // Navigate to the general stats page
                      },
                      child: const Text('Statistiken anschauen'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 50)), // Set the button's height
                      ),
                      onPressed: () {
                        // Navigate to the edit players page
                      },
                      child: const Text('Spieler verwalten'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            // Use PageRouteBuilder for custom page transition to the Profile page
            Navigator.push(
              context,
              CustomPageRouteBuilder.slideInFromRight(const Profile()),
            );
          }
        },
      ),
    );
  }
}
