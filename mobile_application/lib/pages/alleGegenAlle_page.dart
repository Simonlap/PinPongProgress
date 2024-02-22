// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/entities/result.dart';
import 'package:mobile_application/entities/uniqueGame.dart';
import 'package:mobile_application/entities/eloCalculator.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/endGame_page.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/pages/matchList_page.dart';
import 'package:http/http.dart' as http;

class AlleGegenAllePage extends StatefulWidget {
  List<Player> players;
  List<Match>? matches;

  AlleGegenAllePage({required this.players, this.matches});

  @override
  _AlleGegenAlleState createState() => _AlleGegenAlleState();
}

class _AlleGegenAlleState extends State<AlleGegenAllePage> {
  late Future<List<Match>> futureMatches;
  bool hasUpdatedScores = false;

  @override
  void initState() {
    super.initState();
    futureMatches = (widget.matches != null ? Future.value(widget.matches) : generateMatches())
      .then((List<dynamic>? result) { 
        if (result != null) {
          List<Match> matches = result.map<Match>((dynamic item) {
            return Match.fromDynamic(item, () {setState(() {});},);
          }).toList();
          return updateEloScores(matches).then((_) => matches);
        } else {
          return <Match>[];
        }
      });
  }

  Future<void> updateEloScores(List<Match> matches) async {
    widget.players = await EloCalculator.calculateElos(matches, widget.players);
    if (!hasUpdatedScores) {
      setState(() {
        hasUpdatedScores = true; // Prevents further unnecessary rebuilds
      });
    }
  }

  Future<List<Match>> generateMatches() async {
    widget.players.shuffle();
    
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
        final url = Uri.parse(apiUrl + '/api/minigame/entry');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Cookie': jwtToken!,
          },
          body: jsonEncode({
            'player1Id': match.player1.id,
            'player2Id': match.player2.id,
            'pointsPlayer1': 0,
            'pointsPlayer2': 0,
            'roundId': currentUniqueGame?.highestRound,
            'uniqueGameId': currentUniqueGame?.id,
            'minigameId': match.minigameType.index
          }),
        );

        if (response.statusCode == 201) {
          // added successfully
          match.id = Result.fromJson(json.decode(response.body)).id;
          print('Minigame entry created successfully');
          //TODO: Gloable Minigames Variable?
        } else {
          // Handle error
          print('Failed to create minigame entry. Status code: ${response.statusCode}');
        }
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
          FutureBuilder<List<Match>>(
            future: futureMatches, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('An error occurred'));
              } else if (snapshot.hasData) {
                // No need to call updateEloScores here since it's already been handled in initState
                return MatchListPage(
                  matches: snapshot.data!,
                  onResultConfirmed: () {
                    setState(() {});
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0), // Add some spacing between this button and the others
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGamePage(players: widget.players, actionChoice: ActionChoice.intermediateStatus),
                        ),
                      );
                    },
                    child: Text('Zwischenstand anzeigen'), // Replace with your actual button text
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse(apiUrl + '/api/uniqueGames/increaseRound');
                        final response = await http.put(
                          url,
                          headers: {
                            'Content-Type': 'application/json',
                            'Cookie': jwtToken!,
                          },
                          body: jsonEncode({
                            "uniqueGameId": currentUniqueGame?.id
                          }),
                        );
                        if (response.statusCode == 200) {
                          currentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
                          List<Match> matches = await futureMatches;
                          await updateEloScores(matches);

                          print('Next round successfully');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EndGamePage(players: widget.players, actionChoice: ActionChoice.nextRound),
                            ),
                          );
                        } else {
                          // Handle error
                          print('Failed to next round. Status code: ${response.statusCode}');
                        }
                      },
                      child: Text('Nächste Runde'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse(apiUrl + '/api/uniqueGames/exitGame');
                        final response = await http.put(
                          url,
                          headers: {
                            'Content-Type': 'application/json',
                            'Cookie': jwtToken!,
                          },
                          body: jsonEncode({
                            "uniqueGameId": currentUniqueGame?.id
                          }),
                        );
                        if (response.statusCode == 200) {
                          currentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
                          List<Match> matches = await futureMatches;
                          await updateEloScores(matches);
                          print('Game finished successfully');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EndGamePage(players: widget.players, actionChoice: ActionChoice.backToStart),
                            ),
                          );
                        }
                        else {
                          // Handle error
                          print('Failed to finish the game. Status code: ${response.statusCode}');
                        }
                      },
                      child: const Text('Spiel beenden'),
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
