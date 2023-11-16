import 'package:flutter/material.dart';
import 'package:test_application/alleGegenAlle.dart';
import 'package:test_application/customPageRouteBuilder.dart';
import 'package:test_application/gameExplanation.dart';

class PlayersSelection extends StatelessWidget {
  final String pageTitle;

  PlayersSelection(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    List<String> players = ['Player 1', 'Player 2', 'Player 3', 'Player 4'];
    List<bool> selectedPlayers = List.generate(players.length, (index) => true);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Open a new page for game explanation
              Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(
                  GameExplanation('Alle gegen alle'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectablePlayers(players, selectedPlayers),
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
