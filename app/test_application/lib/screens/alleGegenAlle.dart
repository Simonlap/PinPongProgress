import 'package:flutter/material.dart';
import 'package:test_application/elements/bottomNavigationBar.dart';
import 'package:test_application/entities/minigamesEnum.dart';
import 'package:test_application/entities/player.dart';
import 'package:test_application/entities/match.dart';
import 'package:test_application/screens/addResult.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/gameExplanation.dart';

class AlleGegenAlle extends StatefulWidget {
  final List<Player> players;

  AlleGegenAlle({required this.players});

  @override
  _AlleGegenAlleState createState() => _AlleGegenAlleState();
}

class _AlleGegenAlleState extends State<AlleGegenAlle> {
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
        automaticallyImplyLeading: false,
        title: Text(Minigame.alleGegenAlle.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(
                  GameExplanation(Minigame.alleGegenAlle),
                ),
              );
            },
          ),
        ],
      ),
      body: MatchList(
        matches: matches,
        onResultConfirmed: () {
          setState(() { });
        },
      ),
      
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        context: context,
      ),
    );
  }
}

class MatchList extends StatelessWidget {
  final List<Match> matches;
  final VoidCallback onResultConfirmed;

  MatchList({required this.matches, required this.onResultConfirmed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(
                  AddResult(match: matches[index]),
                ),
              );
              onResultConfirmed();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(matches[index].matchName),
                Text(
                  'Result: ${matches[index].pointsPlayer1} - ${matches[index].pointsPlayer2}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
