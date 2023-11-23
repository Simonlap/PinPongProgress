import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/elements/customAlertDialog.dart';
import 'package:test_application/entities/player.dart';
import 'dart:convert';
import 'package:test_application/globalVariables.dart';
import 'package:test_application/screens/addPlayer.dart';
import 'package:test_application/screens/playerDetails.dart';

class ManagePlayers extends StatefulWidget {
  const ManagePlayers({Key? key});

  @override
  _ManagePlayersState createState() => _ManagePlayersState();
}

class _ManagePlayersState extends State<ManagePlayers> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchUserNames() async {
    final url = Uri.parse(apiUrl + '/api/userdata/players');
    final response = await http.get(
      url,
      headers: {
        'Cookie': jwtToken!
      },
    );
    print(jwtToken);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        player = data.map((jsonPlayer) => Player.fromJson(jsonPlayer)).toList();
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }


  Future<void> changePlayerName(newName, id, index) async {

    final url = Uri.parse(apiUrl + '/api/userdata/player/' + id.toString() + '/changeName');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'newPlayerName': newName
      }),
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      player[index] = Player.fromJson(json.decode(response.body));
      setState(() {
        
      });
      // Player added successfully
      print('Player name changed successfully');
  
    } else {
      print('Failed to change player name. Status code: ${response.statusCode}');
    }
  }

  Future<void> deletePlayer(index) async {

    final url = Uri.parse(apiUrl + '/api/userdata/player/' + player[index].id.toString());
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      }
    );

    if (response.statusCode == 200) {
      player.removeAt(index);
      setState(() {
      });
      // Player added successfully
      
      print('Player deleted successfully');
  
    } else {

      print('Failed to delete player. Status code: ${response.statusCode}');
    }
  }

  void _playerAdded() {
    setState(() {
      
    });
  }

  void _navigateToAddPlayer() async {
    // Navigate to AddPlayer screen and wait for the callback function to be called
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayer(
          onUserAdded: (newPlayer) {
            // Callback function to fetch user names when a user is added
            _playerAdded();
          },
        ),
      ),
    );    
  }

  @override
  Widget build(BuildContext context) {
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
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(0, 100),
                          ),
                        ),
                        onPressed: () {
                          // Handle button tap for each user, e.g., navigate to their profile.
                          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(userNames[index]));
                          Navigator.push(
                            context,
                            CustomPageRouteBuilder.slideInFromRight(
                              PlayerDetails(
                                player: player[index],
                                onNameChanged: (newName) {
                                  // Handle name change here if needed
                                  changePlayerName(newName, player[index].id, index);
                                  print('Name changed to: $newName');
                                },
                                onDelete: () {
                                  deletePlayer(index);
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          player[index].name,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(0, 100),
                    ),
                  ),
                  onPressed: () async{
                   _navigateToAddPlayer();
                  },
                  child: const Text('Add Player', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
