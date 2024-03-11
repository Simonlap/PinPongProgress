import 'dart:convert';
import 'dart:math';
import 'package:mobile_application/entities/eloRating.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/globalVariables.dart';

class EloCalculator {
  static const int k = 32; 

  static Future<List<Player>> calculateElos(List<Match> matches, List<Player> players) async {
    Map<int, Player> playerMap = {};

    for (Player player in players) {
      playerMap[player.id] = player;
    }

    for (Match match in matches) {
      Player player1 = match.player1;
      Player player2 = match.player2;
      playerMap[player1.id] ??= player1;
      playerMap[player2.id] ??= player2;

      if (match.pointsPlayer1 == 0 && match.pointsPlayer2 == 0) {
        continue;
      }

      double pA = 1 / (1 + pow(10, (player2.currentElo - player1.currentElo) / 150));
      double pB = 1 - pA; 

      double scoreMargin = (match.pointsPlayer1 - match.pointsPlayer2).abs() / 100.0; 
      scoreMargin = max(1, scoreMargin); 

      // 1 if player 1 won, or has more elo and played draw
      double result1 = (match.pointsPlayer1 > match.pointsPlayer2) || 
          (match.pointsPlayer1 == match.pointsPlayer2 && match.player1.currentElo > match.player2.currentElo) ? 1 : 0;
      double result2 = 1 - result1;

      int newRating1 = (player1.currentElo + k * scoreMargin * (result1 - pA)).round();
      int newRating2 = (player2.currentElo + k * scoreMargin * (result2 - pB)).round();

      await _updatePlayerElo(player1, newRating1);
      await _updatePlayerElo(player2, newRating2);
    }

    return playerMap.values.toList();
  }

  static Future<List<Player>> calculateElosForSevenTable(List<Player> players, Map<int, int> playerPoints) async {
    double averageElo = players.fold(0, (prev, player) => prev + player.currentElo) / players.length;
    int totalPoints = playerPoints.values.fold(0, (prev, points) => prev + points);
    double averagePoints = totalPoints / players.length;
    Map<int, int> eloChanges = {}; // playerId, eloChange

    playerPoints.forEach((playerId, points) {
      Player player = players.firstWhere((p) => p.id == playerId);
      double playerElo = player.currentElo.toDouble();

      double winProbability = 1 / (1 + pow(10, (averageElo - playerElo) / 150));
      double performanceRatio = points > averagePoints ? 1 : 0;
      double scoreMargin = max(1, (points - averagePoints).abs() / 100.0);
      int eloChange = (k * scoreMargin * (performanceRatio - winProbability)).round();

      eloChanges[playerId] = eloChange;
    });

    int totalEloChange = eloChanges.values.fold(0, (prev, change) => prev + change);
    if (totalEloChange != 0) {
      double adjustmentPerPlayer = totalEloChange / eloChanges.length;
      eloChanges = eloChanges.map((playerId, change) {
        int adjustedChange = (change - adjustmentPerPlayer).round();
        return MapEntry(playerId, adjustedChange);
      }).cast<int, int>(); 
    }

    for (var entry in eloChanges.entries) {
      int playerId = entry.key;
      int eloChange = entry.value;

      Player currentPlayer = players.firstWhere((p) => p.id == playerId);
      int newElo = currentPlayer.currentElo + eloChange;

      await _updatePlayerElo(currentPlayer, newElo);
    }

    return players;
  }

  static Future<void> _updatePlayerElo(Player player, int newElo) async {
    DateTime currentDateAndTime = DateTime.now();
    String formattedDate = currentDateAndTime.toIso8601String();
    final url = Uri.parse(apiUrl + '/api/userdata/player/${player.id}/eloRatings');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
         'Cookie': jwtToken!,
      },
      body: jsonEncode({
        "elo": newElo,
        "date": formattedDate,
      }),
    );

    if (response.statusCode == 201) { 
      player.eloRatings.add(EloRating(elo: newElo, date: currentDateAndTime));
    } else {
      print('Failed to update Elo rating for player ${player.id}');
    }
  }
}
