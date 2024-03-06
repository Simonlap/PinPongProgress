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

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  List<int> get player => _player;
  set elo(List<int> value) {
    _player = value;
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] ?? 0,
      name: json['groupName'] ?? '',
      player: json['players'] != null ? List<int>.from(json['players']) : [],
    );
  }
}
