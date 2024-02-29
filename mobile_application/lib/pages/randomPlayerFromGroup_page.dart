import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'dart:math';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/globalVariables.dart';

class RandomPlayerFromGroup extends StatefulWidget {
  final Group group;

  const RandomPlayerFromGroup({Key? key, required this.group}) : super(key: key);

  @override
  _RandomPlayerFromGroupState createState() => _RandomPlayerFromGroupState();
}

class _RandomPlayerFromGroupState extends State<RandomPlayerFromGroup> {
  Player? selectedPlayer;

  void _selectRandomPlayer() {
    final random = Random();
    if (widget.group.player.isNotEmpty) {
      int randomIndex = random.nextInt(widget.group.player.length);
      int playerId = widget.group.player[randomIndex];

      setState(() {
        selectedPlayer = player.firstWhere((element) => element.id == playerId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Zufälliger Spieler aus ${widget.group.name}'
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (selectedPlayer != null)
                Card(
                  elevation: 4.0, // Adds shadow under the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          selectedPlayer!.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8), // Adds space between text and bottom of the card
                        Text(
                          'ELO: ${selectedPlayer!.currentElo}', // Assuming you have a method to get current ELO
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 24), // Adds space between card and button
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
