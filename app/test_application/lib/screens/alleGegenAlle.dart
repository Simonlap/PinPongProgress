
import 'package:flutter/material.dart';
import 'package:test_application/elements/bottomNavigationBar.dart';
import 'package:test_application/entities/minigamesEnum.dart';
import 'package:test_application/screens/addResult.dart';
import 'package:test_application/elements/customPageRouteBuilder.dart';
import 'package:test_application/screens/gameExplanation.dart';

class AlleGegenAlle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: Text(Minigame.alleGegenAlle.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Open a new page for game explanation
              Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(
                  GameExplanation(Minigame.alleGegenAlle),
                ),
              );
            },
          ),
        ],
      ),
      body: MatchList(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        context: context,
      ),
    );
  }
}

class MatchList extends StatelessWidget {
  // Assume you have a list of matches, replace it with your actual data
  final List<String> matches = [
    'Match 1',
    'Match 2',
    'Match 3',
    // ... add more matches
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: ElevatedButton(
            onPressed: () {
              // Navigate to a screen to add match result
              Navigator.push(
                context,
                CustomPageRouteBuilder.slideInFromRight(
                  AddResult(
                    matchName: matches[index],
                  ),
                ),
              );
            },
            child: Text(matches[index]),
          ),
        );
      },
    );
  }
}
