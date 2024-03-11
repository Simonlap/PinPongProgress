class Result {
  int _id;
  int _player1Id;
  int _player2Id;
  int _pointsPlayer1;
  int _pointsPlayer2;
  int _roundId;
  int _uniqueGameId;

  Result(
    this._id,
    this._player1Id,
    this._player2Id,
    this._pointsPlayer1,
    this._pointsPlayer2,
    this._roundId,
    this._uniqueGameId,
  );

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      json['id'] ?? 0,
      json['player1Id'] ?? 0,
      json['player2Id'] ?? 0,
      json['pointsPlayer1'] ?? 0,
      json['pointsPlayer2'] ?? 0,
      json['roundId'] ?? 0,
      json['uniqueGameId'] ?? 0,
    );
  }

  int get id => _id;
  set id(int value) => _id = value;

  int get player1Id => _player1Id;
  set player1Id(int value) => _player1Id = value;

  int get player2Id => _player2Id;
  set player2Id(int value) => _player2Id = value;

  int get pointsPlayer1 => _pointsPlayer1;
  set pointsPlayer1(int value) => _pointsPlayer1 = value;

  int get pointsPlayer2 => _pointsPlayer2;
  set pointsPlayer2(int value) => _pointsPlayer2 = value;

  int get roundId => _roundId;
  set roundId(int value) => _roundId = value;

  int get uniqueGameId => _uniqueGameId;
  set uniqueGameId(int value) => _uniqueGameId = value;
}
