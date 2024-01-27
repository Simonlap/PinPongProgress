import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/pages/matchList_page.dart';

class AlleGegenAllePage extends StatefulWidget {
  final List<Player> players;

  AlleGegenAllePage({required this.players});

  @override
  _AlleGegenAlleState createState() => _AlleGegenAlleState();
}

class _AlleGegenAlleState extends State<AlleGegenAllePage> {
  List<Match> matches = [];

  @override
  void initState() {
    super.initState();
    matches = generateMatches();
  }

  List<Match> generateMatches() {
    List<Match> matches = [];
    for (int i = 0; i < widget.players.length; i += 2) {
      if (i + 1 < widget.players.length) {
        Match match = Match(
          player1: widget.players[i],
          player2: widget.players[i + 1],
          onResultConfirmed: () {
            setState(() {
              // This will trigger a rebuild when points are updated
            });
          },
          minigameType: Minigame.alleGegenAlle
        );
        matches.add(match);
      }
    }
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Minigame.alleGegenAlle.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameExplanationPage(Minigame.alleGegenAlle),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MatchListPage(
            matches: matches,
            onResultConfirmed: () {
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Logic for Next Round
                      },
                      child: Text('Nächste Runde'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Logic for End Game
                      },
                      child: Text('Spiel beenden'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
