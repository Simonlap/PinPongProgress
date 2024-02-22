import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      print('Player name changed successfully');
    } else {
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
      print('Player deleted successfully');
    } else {
      print('Failed to delete player. Status code: ${response.statusCode}');
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
      appBar: AppBar(
        title: const Text(
          'Manage Players',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: player.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0), // Reduced space between buttons
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            // Reduced button height
                            minimumSize: MaterialStateProperty.all(const Size(0, 50)),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(8)), // Reduced padding inside the button
                          ),
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
                          child: Text(
                            player[index].name,
                            style: const TextStyle(fontSize: 20), // Reduced font size
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)), // Reduced button height for 'Add Player'
            ),
            onPressed: _navigateToAddPlayer,
            child: const Text('Add Player', style: TextStyle(fontSize: 20)), // Reduced font size for 'Add Player'
          ),
        ],
      ),
    );
  }
}
