import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/uniqueGame.dart';
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
    fetchPlayers();
    fetchGroups();
    fetchRunningGames();
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
      CustomToast.show(context, "Spieler laden fehlgeschlagen!");
      throw Exception('Failed to load player data');
    }
  }

  Future<void> fetchGroups() async {
    final url = Uri.parse('$apiUrl/api/userdata/groups');
    final response = await http.get(
      url,
      headers: {
        'Cookie': jwtToken!
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        groups = data.map((jsonGroup) => Group.fromJson(jsonGroup)).toList();
      });
    } else {
      CustomToast.show(context, "Gruppen laden fehlgeschlagen!");
      throw Exception('Failed to load group data');
    }
  }

  Future<void> fetchRunningGames() async {
    final url = Uri.parse('$apiUrl/api/uniqueGames/running'); 
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> gamesJson = json.decode(response.body);
      List<UniqueGame> fetchedGames = gamesJson.map((gameJson) => UniqueGame.fromJson(gameJson)).toList();

      // Sort the games (newest first)
      fetchedGames.sort((a, b) => b.startTime.compareTo(a.startTime));
      runningGames = fetchedGames;

    } else {
      CustomToast.show(context, "Laufende Spiel laden fehlgeschlagen!");
      print('Failed to fetch running unique games. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20), 
            CustomElevatedButton.customButton('Minispiel starten', context: context, route: '/minispielepage'),
            SizedBox(height: 20), 
            CustomElevatedButton.customButton('Statistiken anschauen', context: context, route: '/statisticsoverviewpage'),
            SizedBox(height: 20), 
            CustomElevatedButton.customButton('Spieler verwalten', context: context, route: '/manageplayerspage'),
            SizedBox(height: 20),
            CustomElevatedButton.customButton('Laufende Spiele', context: context, route: '/runninguniquegamespage'),
            SizedBox(height: 20),
            CustomElevatedButton.customButton('Tools', context: context, route: '/toolspage'),
          ],
        ),
      ),
    );
  }
}
