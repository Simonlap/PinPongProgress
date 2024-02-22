import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/groupSelection_page.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools'),
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
                        Navigator.pushNamed(context, '/managegroupspage');                   
                      },
                      child: Text('Gruppen Verwalten',
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
                      child: Text('Anwesenheitsliste',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                                    builder: (context) => GroupSelectionPage(option: 1)
                          ),
                        );
                      },
                      child: Text('Zufälligen Spieler auswählen',
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
                                    builder: (context) => GroupSelectionPage(option: 2)
                          ),
                        );
                      },
                      child: Text('Zufällige Gruppe generieren',
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
                                    builder: (context) => GroupSelectionPage(option: 3)
                          ),
                        );
                      },
                      child: Text('Zufällige Paarungen generieren',
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
