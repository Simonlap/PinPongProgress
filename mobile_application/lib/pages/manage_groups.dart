import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'dart:convert';

import 'package:mobile_application/pages/addPlayer_page.dart';
import 'package:mobile_application/pages/groupDetails_page.dart';
import 'package:mobile_application/pages/playerDetails_page.dart';

class ManageGroupsPage extends StatefulWidget {
  const ManageGroupsPage({Key? key});

  @override
  _ManageGroupsState createState() => _ManageGroupsState();
}

class _ManageGroupsState extends State<ManageGroupsPage> {

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
      body: jsonEncode({
        'newPlayerName': newName
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        player[index] = Player.fromJson(json.decode(response.body));
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

  void _navigateToAddPlayer() async {
    // Navigate to AddPlayer screen and wait for the callback function to be called
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayerPage(
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
          'Manage Groups',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return Padding( 
                  padding: EdgeInsets.only(bottom: 10, top: 10),

                    child: Row(
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

                              //navigate to PlayerDetails, handle name change.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupDetailsPage(
                                    groupIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              groups[index].name,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/playerselectiongrouppage');
                  },
                  child: const Text('Add Group', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
