import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_application/elements/customPageRouteBuilder.dart';
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
      setState(() {
        player[index] = Player.fromJson(json.decode(response.body));
      });
      // Player added successfully
      print('Player name changed successfully');
  
    } else {
      // Handle error
      print('Failed to change player name. Status code: ${response.statusCode}');
    }
  }

  void _navigateToAddPlayer() async {
    // Navigate to AddPlayer screen and wait for the callback function to be called
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayer(
          onUserAdded: () {
            // Callback function to fetch user names when a user is added
            setState(() {
              
            });
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
