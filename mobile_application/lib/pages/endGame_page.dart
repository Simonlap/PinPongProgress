import 'package:flutter/material.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/home_page.dart';
import 'package:mobile_application/pages/navigation_page.dart'; // Import your home page file

class EndGamePage extends StatelessWidget {
  final List<Player> players;
  final ActionChoice actionChoice; // New parameter to determine if the game should be terminated

  EndGamePage({required this.players, required this.actionChoice}); // Updated constructor

  @override
  Widget build(BuildContext context) {
    players.sort((a, b) => b.currentElo.compareTo(a.currentElo));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          actionChoice == ActionChoice.backToStart
              ? 'Spiel beenden'
              : actionChoice == ActionChoice.nextRound
                  ? 'Zwischenstand'
                  : 'Zwischenstand',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                // Calculate the difference
                int eloDifference = players[index].currentElo - players[index].eloAtTime(currentUniqueGame!.startTime);
                String formattedDifference = eloDifference >= 0 ? '+$eloDifference' : eloDifference.toString();

                return ListTile(
                  title: Text(players[index].name),
                  subtitle: Text('Elo: ${players[index].currentElo.toString()}, Anfangselo: ${players[index].eloAtTime(currentUniqueGame!.startTime)} ($formattedDifference)'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (actionChoice == ActionChoice.backToStart) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationPage()),
                  (route) => false,
                );
              } else if (actionChoice == ActionChoice.nextRound) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AlleGegenAllePage(players: players)),
                  (route) => false,
                );
              } else if (actionChoice == ActionChoice.intermediateStatus) {
                Navigator.pop(context);
              }
            },
            child: Text(
              actionChoice == ActionChoice.backToStart
                  ? 'Zurück zum Start'
                  : actionChoice == ActionChoice.nextRound
                      ? 'Nächste Runde'
                      : 'Zurück zur Ergebniseingabe',
            )
          ),
        ],
      ),
    );
  }
}

enum ActionChoice {
  backToStart,
  nextRound,
  intermediateStatus, 
}
