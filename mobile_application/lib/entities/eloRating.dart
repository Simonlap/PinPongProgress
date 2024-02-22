class EloRating {
  int elo;
  DateTime date;

  EloRating({
    required this.elo,
    required this.date,
  });

  factory EloRating.fromJson(Map<String, dynamic> json) {
    return EloRating(
      elo: json['elo'] ?? 0,
      date: DateTime.parse(json['date']),
    );
  }
}
