import 'package:flutter/material.dart';
import 'package:test_application/elements/customAlertDialog.dart';
import 'package:test_application/entities/minigamesEnum.dart';
import 'package:test_application/screens/addPlayer.dart';
import 'package:test_application/screens/alleGegenAlle.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/gameExplanation.dart';
import 'package:test_application/globalVariables.dart' as globalVariables;

class PlayersSelection extends StatefulWidget {
  final Minigame selectedMinigame;
  PlayersSelection({required this.selectedMinigame});

  @override
  _PlayersSelectionState createState() => _PlayersSelectionState(selectedMinigame);
}

class _PlayersSelectionState extends State<PlayersSelection> {
  
  final Minigame selectedMiniGame;

  _PlayersSelectionState(this.selectedMiniGame);

  @override
  void initState() {
    super.initState();

    if (globalVariables.player.length == 0) {
      Future.delayed(Duration.zero, () {
        Navigator.push(
          context,
          CustomPageRouteBuilder.slideInFromRight(
            AddPlayer(
              onUserAdded: () {
                setState(() {
                  
                });
              },
            ),
          ),
        );
        showAlert(
          context,
          "Noch keine Spieler",
          "Bitte füge zunächst Spieler hinzu!",
        );
      });
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
                CustomPageRouteBuilder.slideInFromRight(
                  GameExplanation(selectedMiniGame),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectablePlayers(globalVariables.player.map((p) => p.name).toList(),
              selectedPlayers),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(AlleGegenAlle()),
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
  final List<String> players;
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
            title: Text(widget.players[i]),
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
