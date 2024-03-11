import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/pages/addResult_page.dart';

class MatchListPage extends StatelessWidget {
  final List<Match> matches;
  final VoidCallback onResultConfirmed;

  MatchListPage({required this.matches, required this.onResultConfirmed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];  
        return ListTile(
          title: CustomElevatedButton(
            text: match.matchName,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddResultPage(match: match),
                ),
              );
              onResultConfirmed();
            },
            subtitle: 'Ergebnis: ${match.pointsPlayer1} - ${match.pointsPlayer2}',
          ),
        );
      },
    );
  }
}
