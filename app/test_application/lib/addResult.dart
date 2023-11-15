import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class AddResult extends StatefulWidget {
  final String matchName;

  AddResult({required this.matchName});

  @override
  _AddResultState createState() => _AddResultState();
}

class _AddResultState extends State<AddResult> {
  int player1Points = 0;
  int player2Points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Player 1"),
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
                    }
                    else if (player1Points == 10 && player2Points > 10) {
                      player2Points = 12;
                    }
                    else if (player1Points >= 10 && player2Points >= 10) {
                      player2Points = value - 2;
                    }
                    else if (player1Points < 10 && player2Points >= 10) {
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
              Text("Player 2"),
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
                    } 
                    else if (player2Points == 10 && player1Points > 10) {
                      player1Points = 12;
                    }
                    else if (player2Points >= 10 && player1Points >= 10) {
                      player1Points = value - 2;
                    }
                    else if (player2Points < 10 && player1Points >= 10) {
                      player1Points = 11;
                    }
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _confirmResult,
            child: Text('Bestätigen'),
          ),
        ],
      ),
    );
  }

  void _confirmResult() {
    // Implement your logic to confirm and handle the result
  }
}
