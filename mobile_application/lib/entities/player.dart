import 'package:mobile_application/entities/eloRating.dart';

class Player {
  int _id;
  String _name;
  List<EloRating> _eloRatings;

  Player({
    required int id,
    required String name,
    required List<EloRating> eloRatings,
  })   : _id = id,
        _name = name,
        _eloRatings = eloRatings;

  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  List<EloRating> get eloRatings => _eloRatings;
  set eloRatings(List<EloRating> value) {
    _eloRatings = value;
  }

  int get currentElo {
    if (_eloRatings.isNotEmpty) {
      EloRating latestEloRating = _eloRatings.reduce((current, next) => current.date.isAfter(next.date) ? current : next);
      return latestEloRating.elo;
    }
    return 1000;
  }

  int eloAtTime(DateTime dateTime) {
    EloRating? relevantEloRating;

    _eloRatings.sort((a, b) => a.date.compareTo(b.date));

    for (var eloRating in _eloRatings) {
      if (eloRating.date.isBefore(dateTime) || eloRating.date.isAtSameMomentAs(dateTime)) {
        relevantEloRating = eloRating; 
      } else {
        relevantEloRating ??= eloRating;
        break;
      }
    }
    return relevantEloRating?.elo ?? 1000;
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    List<EloRating> eloRatings = [];
    if (json['eloRatings'] != null) {
      eloRatings = List.from(json['eloRatings'])
          .map((eloRatingJson) => EloRating.fromJson(eloRatingJson))
          .toList();
    }
    return Player(
      id: json['id'] ?? 0,
      name: json['playerName'] ?? '',
      eloRatings: eloRatings,
    );
  }
}
