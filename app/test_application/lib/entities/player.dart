class Player {
  int _id;
  String _name;
  int _elo;

  Player({
    required int id,
    required String name,
    required int elo,
  })   : _id = id,
        _name = name,
        _elo = elo;

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

  // Getter for Elo
  int get elo => _elo;

  // Setter for Elo
  set elo(int value) {
    _elo = value;
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] ?? 0,
      name: json['playerName'] ?? '',
      elo: json['elo'] ?? 0,
    );
  }
}
