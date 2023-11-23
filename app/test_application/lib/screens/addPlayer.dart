import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_application/globalVariables.dart';
import 'package:flutter/services.dart';
import 'package:test_application/entities/player.dart';

class AddPlayer extends StatefulWidget {
  final Function(Object)? onUserAdded;

  const AddPlayer({Key? key, this.onUserAdded}) : super(key: key);

  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _eloController = TextEditingController();

  Future<void> addPlayer() async {
    final url = Uri.parse(apiUrl + '/api/userdata/players');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'playerName': _nameController.text,
        'elo': int.parse(_eloController.text),
      }),
    );
    
    if (response.statusCode == 201) {
      // Player added successfully
      print('Player added successfully');
      widget.onUserAdded?.call(Player.fromJson(json.decode(response.body)));
      Navigator.pop(context); // Close the screen after adding the player
    } else {
      // Handle error
      print('Failed to add player. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spieler Erstellen'),
      ),
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
            ElevatedButton(
              onPressed: addPlayer,
              child: Text('Erstellen'),
            ),
          ],
        ),
      ),
    );
  }
}
