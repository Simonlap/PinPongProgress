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

    // Initialize player map with existing players
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

      int rating1 = player1.currentElo;
      int rating2 = player2.currentElo;
      double expectedScore1 = _expectedScore(rating1, rating2);
      double expectedScore2 = _expectedScore(rating2, rating1);

      double result1 = match.pointsPlayer1 > match.pointsPlayer2 ? 1 : 0;
      double result2 = 1 - result1;

      int newRating1 = (rating1 + k * (result1 - expectedScore1)).round();
      int newRating2 = (rating2 + k * (result2 - expectedScore2)).round();

      playerMap[player1.id]!.eloRatings.add(EloRating(elo: newRating1, date: DateTime.now()));
      playerMap[player2.id]!.eloRatings.add(EloRating(elo: newRating2, date: DateTime.now()));

      await _updatePlayerElo(player1.id, newRating1);
      await _updatePlayerElo(player2.id, newRating2);
    }

    return playerMap.values.toList();
  }

  static Future<List<Player>> calculateElosForSevenTable(List<Player> players, Map<int, int> playerPoints) async {
    // Calculate the average ELO rating of all players
    double averageElo = players.fold(0, (prev, player) => prev + player.currentElo) / players.length;

    // Calculate total points scored in the game
    int totalPoints = playerPoints.values.fold(0, (prev, points) => prev + points);

    // Map to store the ELO change for each player
    Map<int, int> eloChanges = {};

    // Calculate ELO changes
    playerPoints.forEach((playerId, points) {
      Player player = players.firstWhere((p) => p.id == playerId);
      double playerElo = player.currentElo.toDouble();

      // Calculate player's performance ratio
      double performanceRatio = totalPoints > 0 ? points / totalPoints : 0;

      // Expected score based on ELO
      double expectedScore = 1 / (1 + pow(10, (averageElo - playerElo) / 400));

      // ELO change based on performance compared to expected score
      int eloChange = (k * 3 * (performanceRatio - expectedScore)).round();

      // Store the ELO change
      eloChanges[playerId] = eloChange;
    });
    // Adjust ELO changes to ensure the sum is zero
    int totalEloChange = eloChanges.values.fold(0, (prev, change) => prev + change);
    if (totalEloChange != 0) {
      int adjustment = (totalEloChange / eloChanges.length).round();
      eloChanges = eloChanges.map((playerId, change) => MapEntry(playerId, change - adjustment));
    }
    // Apply ELO changes to players
    for (var entry in eloChanges.entries) {
      int playerId = entry.key;
      int eloChange = entry.value;

      Player currentPlayer = players.firstWhere((p) => p.id == playerId);
      int newElo = currentPlayer.currentElo + eloChange;

      // Update the player's ELO ratings
      currentPlayer.eloRatings.add(EloRating(elo: newElo, date: DateTime.now()));
      await _updatePlayerElo(currentPlayer.id, newElo);
    }
    return players;
  }

  static Future<void> _updatePlayerElo(int playerId, int newElo) async {
    String currentDateAndTime = DateTime.now().toIso8601String();
    final url = Uri.parse(apiUrl + '/api/userdata/player/$playerId/eloRatings');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
         'Cookie': jwtToken!, //'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "elo": newElo,
        "date": currentDateAndTime,
      }),
    );

    if (response.statusCode != 200) {
      print('Failed to update Elo rating for player $playerId');
    }
  }

  static double _expectedScore(int rating1, int rating2) {
    return 1 / (1 + pow(10, ((rating2 - rating1) / 400)));
  }
}
