import 'package:mobile_application/entities/player.dart';

class Group {
  int _id;
  String _name;
  List<int> _player;

  Group({
    required int id,
    required String name,
    required List<int> player,
  })   : _id = id,
        _name = name,
        _player = player;

  // Getter for ID
  int get id => _id;

  // Setter for ID
  set id(int value) {
    _id = value;
  }

  // Getter for Name
  String get name => _name;

  // Setter for Name
  set name(String value) {
    _name = value;
  }

  // Getter for Player
  List<int> get player => _player;

  // Setter for Player
  set elo(List<int> value) {
    _player = value;
  }
}
