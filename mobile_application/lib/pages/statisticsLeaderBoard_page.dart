import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';// Import your Player model

class StatisticsLeaderBoardPage extends StatefulWidget {
  @override
  _StatisticsLeaderBoardPageState createState() => _StatisticsLeaderBoardPageState();
}

class _StatisticsLeaderBoardPageState extends State<StatisticsLeaderBoardPage> {
  // Sample list of players. Replace with your actual data source.
  late List<Player> allPlayers;

  @override
  void initState() {
    super.initState();
    // Sort players by ELO score in descending order
    allPlayers = player;
    allPlayers.sort((a, b) => b.currentElo.compareTo(a.currentElo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Elo Tabelle',
      ),
      body: ListView.builder(
        itemCount: allPlayers.length,
        itemBuilder: (context, index) {
          // Access the player at the current index
          final player = allPlayers[index];
          // Return a ListTile widget for the current player
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'), // Rank of the player
            ),
            title: Text(player.name),
            trailing: Text('${player.currentElo} elo'),
          );
        },
      ),
    );
  }
}
