import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/navigation_page.dart';

class EndGamePage extends StatelessWidget {
  final List<Player> players;
  final ActionChoice actionChoice; 

  EndGamePage({required this.players, required this.actionChoice});

  @override
  Widget build(BuildContext context) {
    players.sort((a, b) => b.currentElo.compareTo(a.currentElo));

    return Scaffold(
      appBar: CustomAppBar(title: actionChoice == ActionChoice.backToStart
              ? 'Spiel beenden'
              : actionChoice == ActionChoice.nextRound
                  ? 'Zwischenstand'
                  : 'Zwischenstand'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                int eloDifference = players[index].currentElo - players[index].eloAtTime(currentUniqueGame!.startTime);
                String formattedDifference = eloDifference >= 0 ? '+$eloDifference' : eloDifference.toString();

                return ListTile(
                  title: Text(players[index].name),
                  subtitle: Text('Elo: ${players[index].currentElo.toString()}, Anfangselo: ${players[index].eloAtTime(currentUniqueGame!.startTime)} ($formattedDifference)'),
                );
              },
            ),
          ),
          CustomElevatedButton(
            onPressed: () {
              if (actionChoice == ActionChoice.backToStart) {
                deleteCurrentUniqueGame();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationPage()),
                  (route) => false,
                );
              } else if (actionChoice == ActionChoice.nextRound) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlleGegenAllePage(players: players)),
                );
              } else if (actionChoice == ActionChoice.intermediateStatus) {
                Navigator.pop(context);
              }
            },
            text: 
              actionChoice == ActionChoice.backToStart
                  ? 'Zurück zum Start'
                  : actionChoice == ActionChoice.nextRound
                      ? 'Nächste Runde'
                      : 'Zurück zur Ergebniseingabe',
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
