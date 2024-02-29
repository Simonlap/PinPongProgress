import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';

class GameExplanationPage extends StatelessWidget {
  final Minigame? selectedMinigame;

  GameExplanationPage(this.selectedMinigame);

  @override
  Widget build(BuildContext context) {
    final String title = "Erkärung: ${selectedMinigame!.title}";
    final String explanationText = selectedMinigame!.explanation;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Spielerklärung",
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
