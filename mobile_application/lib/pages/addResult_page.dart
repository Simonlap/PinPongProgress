import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/globalVariables.dart';

class AddResultPage extends StatefulWidget {
  final Match match;

  AddResultPage({required this.match});

  @override
  _AddResultState createState() => _AddResultState();
}

class _AddResultState extends State<AddResultPage> {
  late int player1Points;
  late int player2Points;

  @override
  void initState() {
    super.initState();
    player1Points = widget.match.pointsPlayer1; 
    player2Points = widget.match.pointsPlayer2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.match.matchName),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Spieler 1: " + widget.match.player1.name),
              NumberPicker(
                value: player1Points,
                minValue: 0,
                maxValue: 99,
                onChanged: (newValue) => _updatePlayerPoints(newValue, player1Points, player2Points, 
                  (newPoints) => player1Points = newPoints, 
                  (newPoints) => player2Points = newPoints),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Spieler 2: " + widget.match.player2.name),
              NumberPicker(
                value: player2Points,
                minValue: 0,
                maxValue: 99,
                onChanged: (newValue) => _updatePlayerPoints(newValue, player2Points, player1Points, 
                  (newPoints) => player2Points = newPoints, 
                  (newPoints) => player1Points = newPoints),
              ),
            ],
          ),
          CustomElevatedButton(
            onPressed: () => _confirmResult(widget.match),
            text: 'Bestätigen',
          ),
        ],
      ),
    );
  }

  void _updatePlayerPoints(int newValue, int currentPlayerPoints, int otherPlayerPoints, Function(int) setCurrentPlayerPoints, Function(int) setOtherPlayerPoints) {
  setState(() {
    setCurrentPlayerPoints(newValue);
    
    if (newValue > 11) {
      setOtherPlayerPoints(newValue - 2);
    } else if (currentPlayerPoints == 10 && otherPlayerPoints > 10) {
      setOtherPlayerPoints(12);
    } else if (currentPlayerPoints >= 10 && otherPlayerPoints >= 10) {
      setOtherPlayerPoints(newValue - 2);
    } else if (currentPlayerPoints < 10 && otherPlayerPoints >= 10) {
      setOtherPlayerPoints(11);
    }
  });
}

  Future<void> _confirmResult(Match match) async {
    if (!(player1Points == match.pointsPlayer1 && player2Points == match.pointsPlayer2)) {
      final url = Uri.parse(apiUrl + '/api/minigame/editEntry');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jwtToken!,
        },
        body: jsonEncode({
          'id': match.id,
          'pointsPlayer1': player1Points,
          'pointsPlayer2': player2Points,
        }),
      );

      if (response.statusCode == 200) {
        CustomToast.show(context, "Erfolgreich geändert!");
        print('Minigame entry edited successfully');

        match.pointsPlayer1 = player1Points;
        match.pointsPlayer2 = player2Points;

        Navigator.pop(context);
      } else {
        print('Failed to edit minigame entry. Status code: ${response.statusCode}');
        CustomToast.show(context, 'Minigame Ergebnis konnte nicht gespeichert werden!');
      }
    } else {
      Navigator.pop(context);
    }
  }
}
