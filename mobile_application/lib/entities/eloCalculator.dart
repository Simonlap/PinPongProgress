import 'dart:math';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/entities/player.dart';

class EloCalculator {
  static const int k = 32; // Elo k-factor, can be adjusted as needed

  static List<Player> calculateElos(List<Match> matches, List<Player> players) {
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

      int rating1 = player1.elo;
      int rating2 = player2.elo;
      double expectedScore1 = _expectedScore(rating1, rating2);
      double expectedScore2 = _expectedScore(rating2, rating1);

      double result1 = match.pointsPlayer1 > match.pointsPlayer2 ? 1 : 0;
      double result2 = 1 - result1;

      int newRating1 = (rating1 + k * (result1 - expectedScore1)).round();
      int newRating2 = (rating2 + k * (result2 - expectedScore2)).round();

      playerMap[player1.id]!.elo = newRating1;
      playerMap[player2.id]!.elo = newRating2;
    }

    return playerMap.values.toList();
  }

  static double _expectedScore(int rating1, int rating2) {
    return 1 / (1 + pow(10, ((rating2 - rating1) / 400)));
  }
}