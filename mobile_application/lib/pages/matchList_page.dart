import 'package:flutter/material.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/pages/addResult_page.dart';

class MatchListPage extends StatelessWidget {
  final List<Match> matches;  // Change to List<Match> instead of Future<List<Match>>
  final VoidCallback onResultConfirmed;

  MatchListPage({required this.matches, required this.onResultConfirmed});

  @override
  Widget build(BuildContext context) {
    // Directly use matches without FutureBuilder since it's already a List<Match>
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];  // Direct access to match object
        return ListTile(
          title: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddResultPage(match: match),
                ),
              );
              onResultConfirmed();  // Callback after adding result
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(match.matchName),  // Display match name
                Text(
                  'Result: ${match.pointsPlayer1} - ${match.pointsPlayer2}',  // Display match result
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
