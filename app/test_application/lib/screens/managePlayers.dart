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
  List<String> player_names = [];


  @override
  void initState() {
    super.initState();
    fetchUserNames(); // Call the function to fetch user data when the widget initializes.
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
        player_names = data.map((user) => user['playerName'].toString()).toList();
        player = data.map((jsonPlayer) => Player.fromJson(jsonPlayer)).toList();
      });
    } else {
      throw Exception('Failed to load user data');
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
            fetchUserNames();
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
              itemCount: player_names.length,
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
                                  print('Name changed to: $newName');
                                },
                              ),
                            ),
                          );
                          print(player[index].name);
                          print(player[index].id);
                          print(index);
                        },
                        child: Text(
                          player_names[index],
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
