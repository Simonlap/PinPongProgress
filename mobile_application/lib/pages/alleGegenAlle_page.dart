// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
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
      .then((List<Match>? result) {
        if (result != null) {
          return updateEloScores(result).then((_) => result);
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
            setState(() {});
          },
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
          }),
        );

        if (response.statusCode == 201) {
          match.id = Result.fromJson(json.decode(response.body)).id;
          print('Minigame entry created successfully');
        } else {
          print('Failed to create minigame entry. Status code: ${response.statusCode}');
        }
      }
    }
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '${Minigame.alleGegenAlle.title}, Runde: ${currentUniqueGame!.highestRound}', actions: [
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
        ],),
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
                // No call updateEloScores here --> handled in initState
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomElevatedButton(
                    onPressed: _onCurrentResult,
                    text: 'Zwischenstand anzeigen',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      onPressed: _onNextRound,
                      text: 'Nächste Runde',
                    ),
                    CustomElevatedButton(
                      onPressed: _onExitGame,
                      text: 'Spiel beenden',
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

  _onCurrentResult() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndGamePage(players: widget.players, actionChoice: ActionChoice.intermediateStatus),
      ),
    );
  }

  _onNextRound() async {
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
      UniqueGame newCurrentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
      updateUniqueGameInList(runningGames, newCurrentUniqueGame);
      
      List<Match> matches = await futureMatches;
      await updateEloScores(matches);

      print('Next round successfully');
      Navigator.pop(context);
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
  }

  _onExitGame() async {
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

      UniqueGame newCurrentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
      updateUniqueGameInList(runningGames, newCurrentUniqueGame);
      
      List<Match> matches = await futureMatches;
      await updateEloScores(matches);
      print('Game finished successfully');
      Navigator.pop(context);
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
  }
}
