import 'package:flutter/material.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/home_page.dart';
import 'package:mobile_application/pages/navigation_page.dart'; // Import your home page file

class EndGamePage extends StatelessWidget {
  final List<Player> players;
  final bool terminateGame; // New parameter to determine if the game should be terminated

  EndGamePage({required this.players, required this.terminateGame}); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(terminateGame ? 'Spiel beenden' : 'Zwischenstand'), // Change title based on terminateGame parameter
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(players[index].name),
                  subtitle: Text('Elo: ${players[index].elo.toString()}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(terminateGame) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationPage()), 
                  (route) => false,
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AlleGegenAllePage(players: players)),
                  (route) => false,
                );
              }
            },
            child: Text(terminateGame ? 'Zurück zum Start' : 'Nächste Runde'), // Change button text based on terminateGame parameter
          ),
        ],
      ),
    );
  }
}