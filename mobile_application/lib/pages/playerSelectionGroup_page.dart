import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
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

      CustomToast.show(context, "Gruppe hinzugefügt!");
    } else {
      CustomToast.show(context, "Gruppe hinzufügen fehlgeschlagen!");
      print('Failed to add Group. Status code: ${response.statusCode}');
    }
  }
  
  @override
  void dispose() {
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
            controller: _groupNameController,
            decoration: InputDecoration(
              labelText: 'Gruppenname',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded( 
          child: SelectablePlayers(globalVariables.player, selectedPlayers),
        ),
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
        SizedBox(height: 10),
        Expanded( 
          child: ListView.builder(
            itemCount: widget.players.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(widget.players[index].name),
                leading: Checkbox(
                  value: widget.selectedPlayers[index],
                  onChanged: (bool? value) {
                    setState(() {
                      widget.selectedPlayers[index] = value!;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
