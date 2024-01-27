import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    fetchPlayers(); // Call the function to fetch user data when the widget initializes.
  }

  Future<void> fetchPlayers() async {
    final url = Uri.parse('$apiUrl/api/userdata/players');
    final response = await http.get(
      url,
      headers: {
        'Cookie': jwtToken!
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        player = data.map((jsonPlayer) => Player.fromJson(jsonPlayer)).toList();
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/minispielepage');
                      },
                      child: Text('Minispiel Starten',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Gap between the buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Your code here
                      },
                      child: Text('Statistiken anschauen',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Gap between the buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Your code here
                        Navigator.pushNamed(context, '/manageplayerspage');
                      },
                      child: Text('Spieler verwalten',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Your code here
                      },
                      child: Text('Laufende Spiele',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
