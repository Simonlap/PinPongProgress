import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_application/elements/bottomNavigationBar.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/entities/player.dart';
import 'package:test_application/globalVariables.dart';
import 'package:test_application/screens/managePlayers.dart';
import 'package:test_application/screens/minigames.dart';
import 'package:http/http.dart' as http;

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}


class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();

    fetchPlayers(); // Call the function to fetch user data when the widget initializes.
  }

  Future<void> fetchPlayers() async {
    final url = Uri.parse(apiUrl + '/api/userdata/players');
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
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          'Start',
          style: TextStyle(fontSize: 32), // Adjust the font size here
        ),
      ),
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
                        Navigator.push(
                          context,
                          CustomPageRouteBuilder.slideInFromRight(
                              const Minigames()),
                        );
                      },
                      child: const Text('Minispiele starten',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        // Navigate to the general stats page
                      },
                      child: const Text('Statistiken anschauen',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRouteBuilder.slideInFromRight(
                              const ManagePlayers()),
                        );
                      },
                      child: const Text('Spieler verwalten',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(0, 100)), // Set the button's height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRouteBuilder.slideInFromRight(
                              const ManagePlayers()),
                        );
                      },
                      child: const Text('Laufende Minispiele',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        context: context,
      ),
    );
  }
}
