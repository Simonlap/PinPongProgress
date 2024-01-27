import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';

class GameExplanationPage extends StatelessWidget {
  final Minigame selectedMinigame;
  final String explanationTitle;

  // Use a constructor initializer to initialize explanationTitle
  GameExplanationPage(this.selectedMinigame) : explanationTitle = selectedMinigame.title;

  @override
  Widget build(BuildContext context) {
    final String title = "Wie funktioniert $explanationTitle?";
    final String explanationText =
        "Welcome to the Mini Game!\n\nThis game is designed to challenge your skills and have some fun. "
        "Get ready for an exciting experience and enjoy the game.";

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
