import 'package:flutter/material.dart';

class PlayersSelection extends StatelessWidget {
  final String pageTitle;

  PlayersSelection(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    List<String> players = ['Player 1', 'Player 2', 'Player 3', 'Player 4'];
    List<bool> selectedPlayers = List.generate(players.length, (index) => true);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle), // Dynamic title
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.help_outline, // Question mark icon
            size: 32.0,
          ),
          Text('Was ist '), // Clickable text
          SizedBox(height: 20),
          SelectablePlayers(players,
              selectedPlayers), // A widget to display selectable players
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add logic to start the minigame
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
          style: TextStyle(fontWeight: FontWeight.bold),
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
