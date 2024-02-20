import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/entities/uniqueGame.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/addPlayer_page.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/globalVariables.dart' as globalVariables;
import 'package:http/http.dart' as http;

import '../entities/player.dart';

class PlayersSelectionPage extends StatefulWidget {
  final Minigame selectedMinigame;
  PlayersSelectionPage({required this.selectedMinigame});

  @override
  _PlayersSelectionState createState() => _PlayersSelectionState(selectedMinigame);
}

class _PlayersSelectionState extends State<PlayersSelectionPage> {
  
  final Minigame selectedMiniGame;
  final int minimumPlayerNumber = 2;

  _PlayersSelectionState(this.selectedMiniGame);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (globalVariables.player.length < minimumPlayerNumber) {
        int playersLeft = minimumPlayerNumber - globalVariables.player.length;
        // await Fluttertoast.showToast(
        //   msg: "Zu wenig Spieler. Du wirst nun ${playersLeft}x aufgefordert, zunächst Spieler hinzuzufügen.",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
        //TODO:
      }
      checkPlayerCount();
      });
    }

  void checkPlayerCount() async {
  if (globalVariables.player.length < minimumPlayerNumber) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayerPage(
          onUserAdded: () {
            // Callback function to fetch user names when a user is added
            setState(() {

            });
         },
        ),
      ),
    ); 
    // Recursive call to check the player count again after returning from AddPlayer screen
    checkPlayerCount();
  }
}

  @override
  Widget build(BuildContext context) {
    List<bool> selectedPlayers =
        List.generate(globalVariables.player.length, (index) => true);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMiniGame.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Open a new page for game explanation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameExplanationPage(selectedMiniGame),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectablePlayers(globalVariables.player, selectedPlayers),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Here, you can access the selected players as a List<Player>
              List<Player> selectedPlayersList = [];
              for (int i = 0; i < globalVariables.player.length; i++) {
                if (selectedPlayers[i]) {
                  selectedPlayersList.add(globalVariables.player[i]);
                }
              }
              //pop the last to pages from navigation stack
              Navigator.pop(context);
              Navigator.pop(context);

              final String currentDateAndTime = DateTime.now().toIso8601String();
              final url = Uri.parse(apiUrl + '/api/uniqueGames/entry');
              final response = await http.post(
                url,
                headers: {
                  'Content-Type': 'application/json',
                  'Cookie': jwtToken!,
                },
                body: jsonEncode({
                  "isFinished": false,
                  "highestRound": 0,
                  "startTime": currentDateAndTime,
                }),
              );
              if (response.statusCode == 201) {
                currentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
                print('UniqueGame added successfully');
              } else {
                // Handle error
                print('Failed create uniqueGame entry. Status code: ${response.statusCode}');
              }

              // Use the selectedPlayersList as needed
              // For example, you can pass it to the AlleGegenAlle screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlleGegenAllePage(players: selectedPlayersList),
                ),
              );
            },
            child: Text('Los gehts'),
          ),
        ],
      ),
    );
  }
}

class SelectablePlayers extends StatefulWidget {
  final List<Player> players;
  final List<bool> selectedPlayers;

  SelectablePlayers(this.players, this.selectedPlayers);

  @override
  _SelectablePlayersState createState() => _SelectablePlayersState();
}

class _SelectablePlayersState extends State<SelectablePlayers> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Wer soll mitspielen?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        for (int i = 0; i < widget.players.length; i++)
          ListTile(
            title: Text(widget.players[i].name),
            leading: Checkbox(
              value: widget.selectedPlayers[i],
              onChanged: (value) {
                setState(() {
                  widget.selectedPlayers[i] = value!;
                });
              },
            ),
          ),
      ],
    );
  }
}