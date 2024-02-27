class UniqueGame {
  int _id;
  int _highestRound;
  int _userId;
  bool _isFinished;
  DateTime _startTime;
  List<int> _players; 
  int _minigameId;

  UniqueGame(this._id, this._highestRound, this._userId, this._isFinished, this._startTime, this._players, this._minigameId,);

  int get id => _id;
  set id(int value) => _id = value;

  int get highestRound => _highestRound;
  set highestRound(int value) => _highestRound = value;

  int get userId => _userId;
  set userId(int value) => _userId = value;

  bool get isFinished => _isFinished;
  set isFinished(bool value) => _isFinished = value;

  DateTime get startTime => _startTime;
  set startTime(DateTime value) => _startTime = value;

  List<int> get players => _players;
  set players(List<int> value) => _players = value;

  int get minigameId => _minigameId;
  set minigameId(int value) => _minigameId = value;

  factory UniqueGame.fromJson(Map<String, dynamic> json) {
    return UniqueGame(
      json['id'] ?? 0,
      json['highestRound'] ?? 0,
      json['userId'] ?? 0,
      json['isFinished'] ?? false,
      DateTime.parse(json['startTime']),
      (json['players'] as List)?.map((item) => item as int)?.toList() ?? [],
      json['uniqueGameId'] ?? 0,
    );
  }
}
