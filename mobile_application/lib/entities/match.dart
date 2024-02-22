import 'dart:ui';

import 'package:mobile_application/entities/minigamesEnum.dart';
import 'player.dart';

class Match {
  late int _id;
  late Player _player1;
  late Player _player2;
  late String _matchName;
  int _pointsPlayer1 = 0;
  int _pointsPlayer2 = 0;
  late VoidCallback _onResultConfirmed;
  late Minigame _minigameType;

  Match({
    required Player player1,
    required Player player2,
    required VoidCallback onResultConfirmed, 
    required Minigame minigameType
  }) {
    _player1 = player1;
    _player2 = player2;
    _onResultConfirmed = onResultConfirmed; 
    _minigameType = minigameType;
    _updateMatchName();
  }

  Player get player1 => _player1;

  set player1(Player value) {
    _player1 = value;
    _updateMatchName();
  }

  Player get player2 => _player2;

  set player2(Player value) {
    _player2 = value;
    _updateMatchName();
  }

  int get pointsPlayer1 => _pointsPlayer1;

  set pointsPlayer1(int value) {
    _pointsPlayer1 = value;
  }

  int get pointsPlayer2 => _pointsPlayer2;

  set pointsPlayer2(int value) {
    _pointsPlayer2 = value;
  }

  int get id => _id;
  set id(int value) {_id = value; }

  String get matchName => _matchName;

  Minigame get minigameType => _minigameType;

  // No need for a setter for matchName since it's updated automatically
  // Private method to update matchName whenever player1 or player2 changes
  void _updateMatchName() {
    _matchName = '${_player1.name} vs. ${_player2.name}';
  }

  void onResultConfirmed() {

  }

  static Match fromDynamic(dynamic data, VoidCallback onResultConfirmed) {
    if (data is Match) {
      return data;
    } else if (data is Map<String, dynamic>) {
      Player player1 = Player.fromDynamic(data['player1']);
      Player player2 = Player.fromDynamic(data['player2']);
      int pointsPlayer1 = data['pointsPlayer1'] ?? 0; // Provide default value in case it's null
      int pointsPlayer2 = data['pointsPlayer2'] ?? 0; // Provide default value in case it's null
      Minigame minigameType = Minigame.values[data['minigameType']]; // Assuming it's stored as an int index
      VoidCallback _onResultConfirmed = onResultConfirmed; // Use the provided callback
      int id = data['_id']; // Assuming 'id' is also part of your dynamic data

      return Match(
        player1: player1,
        player2: player2,
        onResultConfirmed: onResultConfirmed,
        minigameType: minigameType, 
      )
      ..id = id
      ..pointsPlayer1 = pointsPlayer1
      ..pointsPlayer2 = pointsPlayer2;
    } else {
      throw ArgumentError('Unsupported data type for fromDynamic method');
    }
  }

}