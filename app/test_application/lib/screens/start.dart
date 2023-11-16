import 'package:flutter/material.dart';
import 'package:test_application/elements/bottomNavigationBar.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/managePlayers.dart';
import 'package:test_application/screens/minigames.dart';
import 'package:test_application/screens/profile.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Start',
          style: TextStyle(fontSize: 32), // Adjust the font size here
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
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRouteBuilder.slideInFromRight(
                              const Minigames()),
                        );
                      },
                      child: const Text('Minispiele starten',
                          style: TextStyle(fontSize: 24)),
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
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Navigate to the general stats page
                      },
                      child: const Text('Statistiken anschauen',
                          style: TextStyle(fontSize: 24)),
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
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRouteBuilder.slideInFromRight(
                              const ManagePlayers()),
                        );
                      },
                      child: const Text('Spieler verwalten',
                          style: TextStyle(fontSize: 24)),
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
            Navigator.pushReplacement(
              context,
              CustomPageRouteBuilder.slideInFromRight(const Profile()),
            );
          }
        },
      ),
    );
  }
}
