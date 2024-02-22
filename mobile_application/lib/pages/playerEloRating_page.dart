import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_application/entities/eloRating.dart';
import 'package:mobile_application/globalVariables.dart'; // Adjust the import path as necessary
import 'package:mobile_application/entities/player.dart';

class PlayerEloRatingPage extends StatefulWidget {
  @override
  _PlayerEloRatingPageState createState() => _PlayerEloRatingPageState();
}

enum Scale { Minutes, Hours, Days }

class _PlayerEloRatingPageState extends State<PlayerEloRatingPage> {
  Player? _selectedPlayer;
  Scale _selectedScale = Scale.Days; // Default scale

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player's Elo Rating"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<Player>(
              isExpanded: true,
              value: _selectedPlayer,
              hint: Text('Select a Player'),
              items: player.map((Player player) {
                return DropdownMenuItem<Player>(
                  value: player,
                  child: Text(player.name),
                );
              }).toList(),
              onChanged: (Player? newValue) {
                setState(() {
                  _selectedPlayer = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<Scale>(
              value: _selectedScale,
              onChanged: (Scale? newValue) {
                setState(() {
                  _selectedScale = newValue!;
                });
              },
              items: Scale.values.map((Scale scale) {
                return DropdownMenuItem<Scale>(
                  value: scale,
                  child: Text(scale.toString().split('.').last),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _selectedPlayer != null
                ? _buildEloRatingChart(_selectedPlayer!, _selectedScale)
                : Center(child: Text('Please select a player and scale')),
          ),
        ],
      ),
    );
  }

  Widget _buildEloRatingChart(Player player, Scale scale) {
    // Ensure data is sorted by date to prevent lines going back in time
    List<EloRating> sortedRatings = List<EloRating>.from(player.eloRatings);
    sortedRatings.sort((a, b) => a.date.compareTo(b.date));

    List<charts.Series<EloRating, DateTime>> series = [
      charts.Series<EloRating, DateTime>(
        id: 'EloRating',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EloRating ratings, _) => ratings.date,
        measureFn: (EloRating ratings, _) => ratings.elo,
        data: sortedRatings,
      )
    ];

    var tickProviderSpec;
    switch (scale) {
      case Scale.Minutes:
        tickProviderSpec = charts.AutoDateTimeTickProviderSpec(
          includeTime: true,
        );
        break;
      case Scale.Hours:
        tickProviderSpec = charts.AutoDateTimeTickProviderSpec(
          includeTime: true,
        );
        break;
      case Scale.Days:
        tickProviderSpec = charts.AutoDateTimeTickProviderSpec();
        break;
    }

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickProviderSpec: tickProviderSpec,
      ),
    );
  }
}
