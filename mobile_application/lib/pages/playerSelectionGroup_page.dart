import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/globalVariables.dart' as globalVariables;
import 'package:mobile_application/globalVariables.dart';

import '../entities/player.dart';

class PlayersSelectionGroupPage extends StatefulWidget {
  PlayersSelectionGroupPage();

  @override
  _PlayersSelectionGroupState createState() => _PlayersSelectionGroupState();
}

class _PlayersSelectionGroupState extends State<PlayersSelectionGroupPage> {

  final TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    }
  
  Future<void> saveGroup(String name, List<int> player) async {
    final url = Uri.parse(apiUrl + '/api/userdata/groups');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'groupName': name,
        'players': player,
      }),
    );
    
    if (response.statusCode == 201) {

      groups.add(Group.fromJson(json.decode(response.body)));
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/managegroupspage');

    } else {
      // Handle error
      print('Failed to add Group. Status code: ${response.statusCode}');
    }
  }
  
  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _groupNameController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    List<bool> selectedPlayers =
        List.generate(globalVariables.player.length, (index) => true);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Wähle Spieler aus',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _groupNameController, // Use the controller here
              decoration: InputDecoration(
                labelText: 'Gruppenname', // Label for the input field
                border: OutlineInputBorder(), // Adds a border around the input field
              ),
            ),
          ),
          SelectablePlayers(globalVariables.player, selectedPlayers),
          SizedBox(height: 20),
          CustomElevatedButton(
            text: 'Gruppe erstellen',
            onPressed: () {
              List<int> selectedPlayersList = [];
              for (int i = 0; i < globalVariables.player.length; i++) {
                if (selectedPlayers[i]) {
                  selectedPlayersList.add(globalVariables.player[i].id);
                }
              }
              saveGroup(_groupNameController.text, selectedPlayersList);
          },
          ),
        ],
      ),
    );
  }
}

class SelectablePlayers extends StatefulWidget {
  final List<Player> players;
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
          'Spieler:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        for (int i = 0; i < widget.players.length; i++)
          ListTile(
            title: Text(widget.players[i].name),
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