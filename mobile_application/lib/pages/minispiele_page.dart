import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/pages/imperialTable_page.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class MinispielePage extends StatelessWidget {
  const MinispielePage({super.key});

  Widget _buildGameButton(BuildContext context, Minigame game) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 100)), // Full width and set height
        ),
        onPressed: () {
          if(game == Minigame.siebenerTisch || game == Minigame.alleGegenAlle) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayersSelectionPage(selectedMinigame: game),
              ),
            );
          } else if(game == Minigame.kaisertisch) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImperialTablePage(),
              ),
            );
          } else if(game == Minigame.achtZuAcht || game == Minigame.tikTakToe) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameExplanationPage(game),
              ),
            );
          }
        },
        child: Text(game.title, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minispiele'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to accommodate different screen sizes
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add some padding around the buttons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Minigame.values.map((game) => _buildGameButton(context, game)).toList(),
          ),
        ),
      ),
    );
  }
}
