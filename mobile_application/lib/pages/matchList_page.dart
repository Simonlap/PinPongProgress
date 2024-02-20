import 'package:flutter/material.dart';
import 'package:mobile_application/entities/match.dart';
import 'package:mobile_application/pages/addResult_page.dart';

class MatchListPage extends StatelessWidget {
  final Future<List<Match>> matches;
  final VoidCallback onResultConfirmed;

  MatchListPage({required this.matches, required this.onResultConfirmed});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Match>>(
      future: matches,
      builder: (context, snapshot) {
        // Check if the Future is complete and has data
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // The Future is complete and has data, you can access it using snapshot.data
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final match = snapshot.data![index];
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddResultPage(match: match),
                        ),
                      );
                      onResultConfirmed();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(match.matchName),
                        Text(
                          'Result: ${match.pointsPlayer1} - ${match.pointsPlayer2}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // The Future completed with an error, you can handle it here
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        }

        // By default, show a loading spinner while waiting for the Future to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
