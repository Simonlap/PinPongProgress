import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/playerEloIncrease.dart';
import 'package:mobile_application/globalVariables.dart';

class StatisticsEloGainPage extends StatefulWidget {
  @override
  _StatisticsEloGainPageState createState() => _StatisticsEloGainPageState();
}

class _StatisticsEloGainPageState extends State<StatisticsEloGainPage> {
  late List<PlayerEloIncrease> eloIncreases;
  late List<Player> allPlayers;

  @override
  void initState() {
    super.initState();
    allPlayers = player;
    eloIncreases = calculateEloIncreases();
  }

  List<PlayerEloIncrease> calculateEloIncreases() {

    DateTime currentDate = DateTime.now();
    DateTime oneMonthPrior = DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    List<PlayerEloIncrease> result = [];

    allPlayers.forEach((currentPlayer) {
      int eloGain = currentPlayer.eloAtTime(currentDate) - currentPlayer.eloAtTime(oneMonthPrior);
      PlayerEloIncrease increase = PlayerEloIncrease(playerName: currentPlayer.name, eloIncrease: eloGain);
      result.add(increase);
    });

    result.sort((a, b) => b.eloIncrease.compareTo(a.eloIncrease));

    return result.length > 3 ? result.sublist(0, 3) : result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Player ELO Increases',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildBarChart(),
      ),
    );
  }

  Widget _buildBarChart() {
    List<charts.Series<PlayerEloIncrease, String>> series = [
      charts.Series<PlayerEloIncrease, String>(
        id: 'ELO Increases',
        domainFn: (PlayerEloIncrease increases, _) => increases.playerName,
        measureFn: (PlayerEloIncrease increases, _) => increases.eloIncrease,
        data: eloIncreases,
        labelAccessorFn: (PlayerEloIncrease row, _) => '${row.eloIncrease}',
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(), // Add labels to bars
      domainAxis: new charts.OrdinalAxisSpec(), // Use a string axis for the x-axis (domain)
      // Customize the appearance as needed
    );
  }
}
