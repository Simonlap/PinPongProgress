class UniqueGame {
  int _id;
  int _highestRound;
  int _userId;
  bool _isFinished;

  UniqueGame(this._id, this._highestRound, this._userId, this._isFinished);

  // Getter for _id
  int get id => _id;

  // Setter for _id
  set id(int value) {
    _id = value;
  }

  // Getter for _highestRound
  int get highestRound => _highestRound;

  // Setter for _highestRound
  set highestRound(int value) {
    _highestRound = value;
  }

  // Getter for _userId
  int get userId => _userId;

  // Setter for _userId
  set userId(int value) {
    _userId = value;
  }

  // Getter for _isFinished
  bool get isFinished => _isFinished;

  // Setter for _isFinished
  set isFinished(bool value) {
    _isFinished = value;
  }

  factory UniqueGame.fromJson(Map<String, dynamic> json) {
    return UniqueGame(
      json['id'] ?? 0, // Assuming 'id' is an int and cannot be null
      json['highestRound'] ?? 0, // Assuming 'highestRound' is an int and cannot be null
      json['userId'] ?? 0, // Assuming 'userId' is an int and cannot be null
      json['isFinished'] ?? false, // Assuming 'isFinished' is a bool and cannot be null
    );
  }
}
