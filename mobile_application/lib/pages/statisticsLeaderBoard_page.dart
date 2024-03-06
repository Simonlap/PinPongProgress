import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';

class StatisticsLeaderBoardPage extends StatefulWidget {
  @override
  _StatisticsLeaderBoardPageState createState() => _StatisticsLeaderBoardPageState();
}

class _StatisticsLeaderBoardPageState extends State<StatisticsLeaderBoardPage> {

  late List<Player> allPlayers;

  @override
  void initState() {
    super.initState();

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

          final player = allPlayers[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(player.name),
            trailing: Text('${player.currentElo} elo'),
          );
        },
      ),
    );
  }
}
