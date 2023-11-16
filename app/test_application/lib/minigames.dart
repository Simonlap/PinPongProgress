import 'package:flutter/material.dart';
import 'package:test_application/bottomNavigationBar.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/playersSelection.dart';
import 'package:test_application/profile.dart';

class Minigames extends StatelessWidget {
  const Minigames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Minispiele',
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
                              PlayersSelection("Alle gegen alle")),
                        );
                      },
                      child: const Text('Alle gegen alle',
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
                              PlayersSelection("7er Tunier")),
                        );
                      },
                      child: const Text('7er Tunier',
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
                              PlayersSelection("Kaisertisch")),
                        );
                      },
                      child: const Text('Kaisertisch',
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
