class ResultSevenTable {
  int _id;
  int _userId;
  int _playerId;
  int _pointsPlayer;
  int _uniqueGameId;
  DateTime _editTime;

  ResultSevenTable(
    this._id,
    this._userId,
    this._playerId,
    this._pointsPlayer,
    this._uniqueGameId,
    this._editTime,
  );

  // Factory constructor to create a ResultSevenTable instance from a JSON map
  factory ResultSevenTable.fromJson(Map<String, dynamic> json) {
    return ResultSevenTable(
      json['id'] ?? 0,
      json['userId'] ?? 0,
      json['playerId'] ?? 0,
      json['pointsPlayer'] ?? 0,
      json['uniqueGameId'] ?? 0,
      DateTime.parse(json['editTime'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Getters and Setters
  int get id => _id;
  set id(int value) => _id = value;

  int get userId => _userId;
  set userId(int value) => _userId = value;

  int get playerId => _playerId;
  set playerId(int value) => _playerId = value;

  int get pointsPlayer => _pointsPlayer;
  set pointsPlayer(int value) => _pointsPlayer = value;

  int get uniqueGameId => _uniqueGameId;
  set uniqueGameId(int value) => _uniqueGameId = value;

  DateTime get editTime => _editTime;
  set editTime(DateTime value) => _editTime = value;
}
