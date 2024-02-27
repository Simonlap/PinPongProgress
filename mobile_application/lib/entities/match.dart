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

  Match({
    required Player player1,
    required Player player2,
    required VoidCallback onResultConfirmed, 
  }) {
    _player1 = player1;
    _player2 = player2;
    _onResultConfirmed = onResultConfirmed; 
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

  // No need for a setter for matchName since it's updated automatically
  // Private method to update matchName whenever player1 or player2 changes
  void _updateMatchName() {
    _matchName = '${_player1.name} vs. ${_player2.name}';
  }

  void onResultConfirmed() {

  }
}