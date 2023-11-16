import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_application/globalVariables.dart';

class ManagePlayers extends StatefulWidget {
  const ManagePlayers({Key? key});

  @override
  _ManagePlayersState createState() => _ManagePlayersState();
}

class _ManagePlayersState extends State<ManagePlayers> {
  List<String> userNames = [];

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
        userNames = data.map((user) => user['playerName'].toString()).toList();
        print('hier');
        print(userNames);
      });
    } else {
      throw Exception('Failed to load user data');
    }
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
              itemCount: userNames.length,
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
                        },
                        child: Text(
                          userNames[index],
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
                  onPressed: () {
                    // Handle the "Add Player" button tap, e.g., navigate to a page for adding a new player.
                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlayerPage()));
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
