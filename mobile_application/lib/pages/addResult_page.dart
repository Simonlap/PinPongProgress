import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/globalVariables.dart';

class AddResultPage extends StatefulWidget {
  final Match match;

  AddResultPage({required this.match});

  @override
  _AddResultState createState() => _AddResultState(match);
}

class _AddResultState extends State<AddResultPage> {
  final Match match;

  _AddResultState(this.match);

  int player1Points = 0;
  int player2Points = 0;

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
              Text("Spieler 1: " + match.player1.name),
              NumberPicker(
                value: player1Points,
                minValue: 0,
                maxValue: 99,
                onChanged: (value) {
                  setState(() {
                    player1Points = value;
                    // Ensure a 2-point difference when the selected value is higher than 11
                    if (player1Points > 11) {
                      player2Points = value - 2;
                    } else if (player1Points == 10 && player2Points > 10) {
                      player2Points = 12;
                    } else if (player1Points >= 10 && player2Points >= 10) {
                      player2Points = value - 2;
                    } else if (player1Points < 10 && player2Points >= 10) {
                      player2Points = 11;
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Spieler 2: " + match.player2.name),
              NumberPicker(
                value: player2Points,
                minValue: 0,
                maxValue: 99,
                onChanged: (value) {
                  setState(() {
                    player2Points = value;
                    // Ensure a 2-point difference when the selected value is higher than 11
                    if (player2Points > 11) {
                      player1Points = value - 2;
                    } else if (player2Points == 10 && player1Points > 10) {
                      player1Points = 12;
                    } else if (player2Points >= 10 && player1Points >= 10) {
                      player1Points = value - 2;
                    } else if (player2Points < 10 && player1Points >= 10) {
                      player1Points = 11;
                    }
                  });
                },
              ),
            ],
          ),
          CustomElevatedButton(
            onPressed: _confirmResult,
            text: 'Bestätigen',
          ),
        ],
      ),
    );
  }

  Future<void> _confirmResult() async {
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
        print('Minigame entry edited successfully');

        match.pointsPlayer1 = player1Points;
        match.pointsPlayer2 = player2Points;

        Navigator.pop(context);
      } else {
        // Handle error
        print('Failed to edit minigame entry. Status code: ${response.statusCode}');

        // Fluttertoast.showToast(
        //   msg: "Minigame Ergebnis konnte nicht hinzugefügt werden!",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
      }
    } else {
      Navigator.pop(context);
    }
  }
}
