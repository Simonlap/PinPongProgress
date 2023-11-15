import 'package:flutter/material.dart';

class GameExplanation extends StatelessWidget {
  final String pageTitle;

  GameExplanation(this.pageTitle);

  final String title = "Wie funktionierts?";
  final String explanationText =
      "Welcome to the Mini Game!\n\nThis game is designed to challenge your skills and have some fun. "
      "Get ready for an exciting experience and enjoy the game.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Game Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              explanationText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}