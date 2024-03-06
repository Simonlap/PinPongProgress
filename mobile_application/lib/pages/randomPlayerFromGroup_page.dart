import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'dart:math';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';

class RandomPlayerFromGroup extends StatefulWidget {
  final List<Player> players;

  const RandomPlayerFromGroup({Key? key, required this.players}) : super(key: key);

  @override
  _RandomPlayerFromGroupState createState() => _RandomPlayerFromGroupState();
}

class _RandomPlayerFromGroupState extends State<RandomPlayerFromGroup> {
  Player? selectedPlayer;

  void _selectRandomPlayer() {
    final random = Random();
    if (widget.players.isNotEmpty) {
      int randomIndex = random.nextInt(widget.players.length);
      int playerId = widget.players[randomIndex].id;

      setState(() {
        selectedPlayer = player.firstWhere((element) => element.id == playerId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Zufälliger Spieler'
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (selectedPlayer != null)
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          selectedPlayer!.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'ELO: ${selectedPlayer!.currentElo}',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20), 
              CustomElevatedButton(
                onPressed: _selectRandomPlayer,
                text: 'Zufälligen Spieler auswählen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
