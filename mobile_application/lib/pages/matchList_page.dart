import 'package:flutter/material.dart';

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
                CustomPageRouteBuilder.slideInFromRight(
                  AddResult(match: matches[index]),
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