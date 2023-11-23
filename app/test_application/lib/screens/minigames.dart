import 'package:flutter/material.dart';
import 'package:test_application/elements/bottomNavigationBar.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/entities/minigamesEnum.dart';
import 'package:test_application/screens/playersSelection.dart';

class Minigames extends StatelessWidget {
  const Minigames({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minispiele',
          style: TextStyle(fontSize: 32), // Adjust the font size here
        ),
        automaticallyImplyLeading: true,
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
                              PlayersSelection(selectedMinigame: Minigame.alleGegenAlle)),
                        );
                      },
                      child: Text(Minigame.alleGegenAlle.title,
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
                              PlayersSelection(selectedMinigame: Minigame.siebenerTisch)),
                        );
                      },
                      child: Text(Minigame.siebenerTisch.title,
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
                              PlayersSelection(selectedMinigame: Minigame.kaisertisch)),
                        );
                      },
                      child: Text(Minigame.kaisertisch.title,
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
        context: context,
      ),
    );
  }
}
