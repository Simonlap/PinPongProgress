import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/entities/eloRating.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:flutter/services.dart';

class AddPlayerPage extends StatefulWidget {
  final Function()? onUserAdded;

  const AddPlayerPage({Key? key, this.onUserAdded}) : super(key: key);

  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayerPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _eloController = TextEditingController();

  Future<void> addPlayer() async {
  EloRating eloRating = EloRating(date: DateTime.now(), elo: int.parse(_eloController.text));

    final url = Uri.parse(apiUrl + '/api/userdata/players');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'playerName': _nameController.text,
        'eloRatings': [eloRating.toJson()],
      }),
    );
    
    if (response.statusCode == 201) {
      CustomToast.show(context, 'Spieler erfolgreich hinzugefügt!');
      print('Player added successfully');

      widget.onUserAdded?.call();
      player.add(Player.fromJson(json.decode(response.body)));
      Navigator.pop(context); 
    } else {
      CustomToast.show(context, "Spieler nicht hinzugefügt!");
      print('Failed to add player. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Spieler erstellen'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Player Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _eloController,
              decoration: InputDecoration(labelText: 'Player Elo'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ]
            ),
            SizedBox(height: 32),
            CustomElevatedButton(
              onPressed: addPlayer,
              text: 'Erstellen',
            ),
          ],
        ),
      ),
    );
  }
}
