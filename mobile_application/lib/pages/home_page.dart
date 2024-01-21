import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.pushNamed(context, '/allegegenallepage');
                      },
                      child: Text('Alle gegen Alle',
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
                        
                      },
                      child: Text('Siebener Tisch',
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