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

  // Getter for Elo Ratings
  List<EloRating> get eloRatings => _eloRatings;

  // Setter for Elo Ratings
  set eloRatings(List<EloRating> value) {
    _eloRatings = value;
  }

  int get currentElo {
    if (_eloRatings.isNotEmpty) {
      // Find the EloRating with the most recent date
      EloRating latestEloRating = _eloRatings.reduce((current, next) => current.date.isAfter(next.date) ? current : next);
      return latestEloRating.elo;
    }
    // Return a default Elo rating if the list is empty
    return 1000; // This is a typical starting Elo rating
  }

  int eloAtTime(DateTime dateTime) {
    EloRating? relevantEloRating;

    // Sort the Elo ratings by date in ascending order
    _eloRatings.sort((a, b) => a.date.compareTo(b.date));

    // Iterate through the sorted Elo ratings
    for (var eloRating in _eloRatings) {
      if (eloRating.date.isBefore(dateTime) || eloRating.date.isAtSameMomentAs(dateTime)) {
        relevantEloRating = eloRating; 
      } else {
        relevantEloRating ??= eloRating;
        break;
      }
    }
    // Return the found Elo rating, or a default value if none is found
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
