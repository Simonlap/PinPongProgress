import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class StatisticsOverviewPage extends StatelessWidget {
  const StatisticsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stistiken'),
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
                             Navigator.pushNamed(context, "/playerelochartpage");          
                      },
                      child: Text('Elo Rating Verlauf',
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
                      child: Text('Top Elo Zuwachs',
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
                      child: Text('TBD',
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
