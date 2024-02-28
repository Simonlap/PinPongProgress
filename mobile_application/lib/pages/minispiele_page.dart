import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class MinispielePage extends StatelessWidget {
  const MinispielePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minispiele'),
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
                          MaterialPageRoute(
                            builder: (context) => PlayersSelectionPage(selectedMinigame: Minigame.alleGegenAlle),
                          ),
                        );                       
                      },
                      child: Text(Minigame.alleGegenAlle.title,
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Gap between the buttons
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
                          MaterialPageRoute(
                            builder: (context) => PlayersSelectionPage(selectedMinigame: Minigame.siebenerTisch),
                          ),
                        ); 
                      },
                      child: Text(Minigame.siebenerTisch.title,
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Gap between the buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Your code here
                      },
                      child: Text('Kaisertisch',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
