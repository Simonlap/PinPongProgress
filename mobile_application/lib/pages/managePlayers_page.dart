import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'dart:convert';

import 'package:mobile_application/pages/addPlayer_page.dart';
import 'package:mobile_application/pages/playerDetails_page.dart';

class ManagePlayersPage extends StatefulWidget {
  const ManagePlayersPage({Key? key});

  @override
  _ManagePlayersState createState() => _ManagePlayersState();
}

class _ManagePlayersState extends State<ManagePlayersPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> changePlayerName(newName, id, index) async {
    final url = Uri.parse('$apiUrl/api/userdata/player/' + id.toString() + '/changeName');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({'newPlayerName': newName}),
    );

    if (response.statusCode == 200) {
      setState(() {
        player[index] = Player.fromJson(json.decode(response.body));
      });

      CustomToast.show(context, "Spielername geändert!");
      print('Player name changed successfully');
    } else {
      CustomToast.show(context, "Spielername ändern fehlgeschlagen!");
      print('Failed to change player name. Status code: ${response.statusCode}');
    }
  }

  Future<void> deletePlayer(index) async {
    final url = Uri.parse(apiUrl + '/api/userdata/player/' + player[index].id.toString());
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json', 'Cookie': jwtToken!},
    );

    if (response.statusCode == 200) {
      setState(() {
        player.removeAt(index);
      });

      CustomToast.show(context, "Spieler gelöscht!");
      print('Player deleted successfully');
    } else {
      print('Failed to delete player. Status code: ${response.statusCode}');
      // CustomToast.show(context, "Spieler löschen fehlgeschlagen!");
      // TODO: Player deleted twice so that an error occurs every time a player is deleted. It currently does not lead to further problems.
    }
  }

  void _navigateToAddPlayer() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayerPage(
          onUserAdded: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    player.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Spieler verwalten',
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: player.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0), 
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomElevatedButton.customButton(
                          player[index].name,
                          minimumSize: Size(0, 50),
                          subtitle: 'Elo: ${player[index].currentElo}',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayerDetailsPage(
                                  player: player[index],
                                  onDelete: () => deletePlayer(index),
                                  onNameChanged: (newName) => changePlayerName(newName, player[index].id, index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          CustomElevatedButton.customButton(
            'Spieler hinzufügen',
            onPressed: _navigateToAddPlayer,
          ),
        ],
      ),
    );
  }
}
