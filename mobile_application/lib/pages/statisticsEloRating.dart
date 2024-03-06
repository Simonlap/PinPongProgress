import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_application/elements/customAppBar.dart';
import 'dart:math' as Math;
import 'package:mobile_application/entities/eloRating.dart'; 
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';

class StatisticsEloRatingPage extends StatefulWidget {
  @override
  _StatisticsEloRatingPageState createState() => _StatisticsEloRatingPageState();
}

class _StatisticsEloRatingPageState extends State<StatisticsEloRatingPage> {
  Player? _selectedPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Elo Verlauf",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<Player>(
              isExpanded: true,
              value: _selectedPlayer,
              hint: Text('Spieler auswählen'),
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
          Expanded(
            child: _selectedPlayer != null
                ? _buildEloRatingChart(_selectedPlayer!)
                : Center(child: Text('Bite zuerst Spieler auswählen')),
          ),
        ],
      ),
    );
  }

  Widget _buildEloRatingChart(Player player) {
    List<EloRating> sortedRatings = List<EloRating>.from(player.eloRatings);
    sortedRatings.sort((a, b) => a.date.compareTo(b.date));

    final minElo = sortedRatings.map<double>((rating) => rating.elo.toDouble()).fold(double.infinity, (double previousValue, double elo) => Math.min(previousValue, elo));
    final maxElo = sortedRatings.map<double>((rating) => rating.elo.toDouble()).fold(-double.infinity, (double previousValue, double elo) => Math.max(previousValue, elo));

    final yAxisStart = minElo - (minElo * 0.05); // Start 5% below the minimum elo
    final yAxisEnd = maxElo + (maxElo * 0.05); // End 5% above the maximum elo
    final range = yAxisEnd - yAxisStart;

    double tickInterval;
    if (range <= 10) {
      tickInterval = 1; 
    } else if (range <= 50) {
      tickInterval = 5; 
    } else if (range <= 100) {
      tickInterval = 10; 
    } else {
      tickInterval = (range / 10).ceilToDouble();
    }

    List<charts.Series<EloRating, DateTime>> series = [
      charts.Series<EloRating, DateTime>(
        id: 'EloRating',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (EloRating ratings, _) => ratings.date,
        measureFn: (EloRating ratings, _) => ratings.elo,
        data: sortedRatings,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickProviderSpec: charts.AutoDateTimeTickProviderSpec(), 
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        viewport: charts.NumericExtents(yAxisStart, yAxisEnd),
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          List.generate((range / tickInterval).ceil(), (index) => charts.TickSpec(index * tickInterval + yAxisStart, label: '${index * tickInterval + yAxisStart}'))
        ),
      ),
    );
  }
}