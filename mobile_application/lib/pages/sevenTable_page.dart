import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For date formatting
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'dart:convert';

class SevenTablePage extends StatefulWidget {
  final List<Player> players;

  SevenTablePage({Key? key, required this.players}) : super(key: key);

  @override
  _SevenTablePageState createState() => _SevenTablePageState();
}

class _SevenTablePageState extends State<SevenTablePage> {
  Map<int, ValueNotifier<int>> playerPoints = {};
  Map<int, DateTime> lastEdited = {};

  Future<void> _fetchInitialPoints() async {
    final url = Uri.parse('${apiUrl}/api/sevenTable/results/${currentUniqueGame!.id}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Cookie': jwtToken!,
    });

    if (response.statusCode == 200) {
      List<dynamic> resultData = jsonDecode(response.body);
      if (resultData.isEmpty) {
        for (Player player in widget.players) {
          await _createInitialEntry(player.id);
        }
        return _fetchInitialPoints(); // Fetch again after creating initial entries
      } else {
        for (var result in resultData) {
          playerPoints[result['playerId']] = ValueNotifier<int>(result['pointsPlayer']);
          lastEdited[result['playerId']] = DateTime.parse(result['editTime']);
        }
      }
    } else {
      print('Error fetching seven table results: ${response.body}');
    }
  }

  Future<void> _createInitialEntry(int playerId) async {
    final url = Uri.parse('${apiUrl}/api/sevenTable/entry');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'playerId': playerId,
        'pointsPlayer': 0,
        'uniqueGameId': currentUniqueGame!.id,
        'editTime': DateTime.now().toIso8601String(),
      }),
    );
    if (response.statusCode == 201) {
      print('Initial seven table entry created for player ID $playerId');
    } else {
      print('Error creating initial seven table entry: ${response.body}');
    }
  }

  Future<void> _updatePoints(int playerId, bool increase) async {
    final url = Uri.parse('${apiUrl}/api/sevenTable/${increase ? 'increase' : 'decrease'}Entry/${currentUniqueGame!.id}/${playerId}');
    final response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Cookie': jwtToken!,
    });

    if (response.statusCode == 200) {
      final resultData = jsonDecode(response.body);
      playerPoints[playerId]?.value = resultData['pointsPlayer']; // Update the ValueNotifier
      lastEdited[playerId] = DateTime.parse(resultData['editTime']);
    } else {
      print('Error updating points: ${response.body}');
    }
  }

  Future<void> _exitUniqueGame() async {
    final url = Uri.parse('${apiUrl}/api/uniqueGames/exitGame');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'uniqueGameId': currentUniqueGame!.id,
      }),
    );

    if (response.statusCode == 200) {
      print('Exited game successfully');
      deleteCurrentUniqueGame();
      Navigator.pop(context);
    } else {
      print('Failed to exit game: ${response.body}');
    }
  }


  void _increasePoints(Player player) => _updatePoints(player.id, true);

  void _decreasePoints(Player player) => _updatePoints(player.id, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Minigame.siebenerTisch.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameExplanationPage(Minigame.siebenerTisch),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _fetchInitialPoints(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: widget.players.length,
                  itemBuilder: (context, index) {
                    final player = widget.players[index];
                    return ListTile(
                      title: Text(player.name),
                      subtitle: Text('Zuletzt geändert: ${DateFormat('hh:mm:ss').format(lastEdited[player.id]!)} Uhr'),
                      trailing: playerPoints[player.id] != null
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => _decreasePoints(player),
                                ),
                                ValueListenableBuilder<int>(
                                  valueListenable: playerPoints[player.id]!,
                                  builder: (_, value, __) {
                                    return Text('$value');
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => _increasePoints(player),
                                ),
                              ],
                            )
                          : SizedBox.shrink(), // Placeholder for null values in playerPoints
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _exitUniqueGame,
              child: Text('Spiel beenden'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button with fixed height
              ),
            ),
          ),
        ],
      ),
    );
  }
}
