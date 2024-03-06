import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/result.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/globalVariables.dart' as globalVariables;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/sevenTable_page.dart';

class RunningUniqueGamesPage extends StatefulWidget {
  const RunningUniqueGamesPage({Key? key}) : super(key: key);

  @override
  _RunningUniqueGamesPageState createState() => _RunningUniqueGamesPageState();
}

class _RunningUniqueGamesPageState extends State<RunningUniqueGamesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Laufende Spiele',
      ),
      body: ListView.builder(
        itemCount: runningGames.length,
        itemBuilder: (context, index) {
          final startTime = DateFormat("dd.MM.yyyy 'um' HH:mm 'Uhr'").format(runningGames[index].startTime);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomElevatedButton(
                    text: '${Minigame.values[runningGames[index].minigameId].title}: $startTime',
                    subtitle: Minigame.values[runningGames[index].minigameId] == Minigame.siebenerTisch
                            ? 'Spieleranzahl: ${runningGames[index].players.length}'
                            : 'Höchste Runde: ${runningGames[index].highestRound}',
                    onPressed: () => handleOnPressed(index),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  handleOnPressed(int index) async {
    if(runningGames[index].minigameId == Minigame.alleGegenAlle.id) {
      final url = Uri.parse('$apiUrl/api/minigame/results/${runningGames[index].id}/${runningGames[index].highestRound}'); 
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jwtToken!,
        },
      );

      if (response.statusCode == 200) {
        updateUniqueGameInList(runningGames, runningGames[index]);
        
        List<dynamic> data = json.decode(response.body);
        List<Result> results = data.map((json) => Result.fromJson(json)).toList();

        List<Match> matches = results.map((result) {
          Player player1 = globalVariables.player.firstWhere((player) => player.id == result.player1Id, orElse: () => Player(id: -1, name: 'Unknown', eloRatings: []));
          Player player2 = globalVariables.player.firstWhere((player) => player.id == result.player2Id, orElse: () => Player(id: -1, name: 'Unknown', eloRatings: []));
          
          return Match(
            player1: player1,
            player2: player2,
            onResultConfirmed: () {
              setState(() {});
            },
          )..id = result.id
          ..pointsPlayer1 = result.pointsPlayer1
          ..pointsPlayer2 = result.pointsPlayer2;
        }).toList();

        List<Player> mappedPlayers = runningGames[index].players.map((playerId) {
          return player.firstWhere((player) => player.id == playerId, orElse: () => Player(id: -1, name: 'Unknown', eloRatings: []));
        }).where((player) => player != null).toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlleGegenAllePage(players: mappedPlayers, matches: matches),
          ),
        ).then((_) {
          setState(() {});
        });
      } else { 

        CustomToast.show(context, "Spiel laden fehlgeschlagen!");
        print('Failed to fetch. Status code: ${response.statusCode}');
        
      }

    } else if(runningGames[index].minigameId == Minigame.siebenerTisch.id) {
      updateUniqueGameInList(runningGames, runningGames[index]);

      List<Player> mappedPlayers = runningGames[index].players.map((playerId) {
          return player.firstWhere((player) => player.id == playerId, orElse: () => Player(id: -1, name: 'Unknown', eloRatings: []));
        }).where((player) => player != null).toList(); // filter out any null values in case a playerId doesn't match

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SevenTablePage(players: mappedPlayers),
        ),
      ).then((_) {
        setState(() {});
      });
    }
  }
}
