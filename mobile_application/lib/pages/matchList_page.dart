import 'package:flutter/material.dart';
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
        return ListTile(
          title: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  //hier add result
                  builder: (context) => AddResultPage(match: matches[index]),
                ),
              );
              onResultConfirmed();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(matches[index].matchName),
                Text(
                  'Result: ${matches[index].pointsPlayer1} - ${matches[index].pointsPlayer2}',
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