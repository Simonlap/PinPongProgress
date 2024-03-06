import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/elements/customToast.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/entities/uniqueGame.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/addPlayer_page.dart';
import 'package:mobile_application/pages/alleGegenAlle_page.dart';
import 'package:mobile_application/pages/endGame_page.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/globalVariables.dart' as globalVariables;
import 'package:http/http.dart' as http;
import 'package:mobile_application/pages/randomGroupFromGroup_page.dart';
import 'package:mobile_application/pages/randomPlayerFromGroup_page.dart';
import 'package:mobile_application/pages/sevenTable_page.dart';

import '../entities/player.dart';

class PlayersSelectionPage extends StatefulWidget {
  final Minigame? selectedMinigame;
  final ActionChoice actionChoice;

  PlayersSelectionPage({this.selectedMinigame, required this.actionChoice});

  @override
  _PlayersSelectionState createState() => _PlayersSelectionState();
}

class _PlayersSelectionState extends State<PlayersSelectionPage> {
  
  List<bool> selectedPlayers = [];
  final int minimumPlayerNumber = 2;

  _PlayersSelectionState();

  @override
  void initState() {
    super.initState();

    selectedPlayers = List.generate(globalVariables.player.length, (index) => false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (globalVariables.player.length < minimumPlayerNumber) {
        int playersLeft = minimumPlayerNumber - globalVariables.player.length;
        CustomToast.show(context, "Zu wenig Spieler. Du wirst nun ${playersLeft}x aufgefordert, zunächst Spieler hinzuzufügen.");
      }
      checkPlayerCount();
      });
    }

  void checkPlayerCount() async {
  if (globalVariables.player.length < minimumPlayerNumber) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlayerPage(
          onUserAdded: () {
            setState(() {});
         },
        ),
      ),
    ); 
    // check the player count again after returning from AddPlayer screen
    checkPlayerCount();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.selectedMinigame != null ? widget.selectedMinigame!.title : 'Wähle Spieler aus',
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameExplanationPage(widget.selectedMinigame),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Text(
              'Wer soll mitspielen?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Expanded( 
            child: SelectablePlayers(globalVariables.player, selectedPlayers, globalVariables.groups),
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            text: 'Los gehts',
            onPressed:() => performSelection(),
          ),
        ],
      ),
    );
  }
  
  performSelection() async {

    List<Player> selectedPlayersList = [];

    for (int i = 0; i < globalVariables.player.length; i++) {
      if (selectedPlayers[i]) {  
        selectedPlayersList.add(globalVariables.player[i]);
      }
    }

    if (selectedPlayersList.isNotEmpty) {
      if(widget.actionChoice == ActionChoice.minigame && widget.selectedMinigame != null) {

        Navigator.pop(context); 
        Navigator.pop(context); 

        final String currentDateAndTime = DateTime.now().toIso8601String();
        final List<int> selectedPlayerIds = selectedPlayersList.map((player) => player.id).toList();
        final url = Uri.parse(apiUrl + '/api/uniqueGames/entry');
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Cookie': jwtToken!,
          },
          body: jsonEncode({
            "isFinished": false,
            "highestRound": 1,
            "startTime": currentDateAndTime,
            "players": selectedPlayerIds, 
            "minigameId": widget.selectedMinigame!.id,
          }),
        );
        if (response.statusCode == 201) {
          UniqueGame newCurrentUniqueGame = UniqueGame.fromJson(json.decode(response.body));
          updateUniqueGameInList(runningGames, newCurrentUniqueGame);
          
          print('UniqueGame added successfully');
        } else {
          CustomToast.show(context, "Spiele erstellen fehlgeschlagen!");
          print('Failed to create uniqueGame entry. Status code: ${response.statusCode}');
        }

        if(widget.selectedMinigame == Minigame.alleGegenAlle) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlleGegenAllePage(players: selectedPlayersList),
            ),
          );
        }
        else if(widget.selectedMinigame == Minigame.siebenerTisch) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SevenTablePage(players: selectedPlayersList),
            ),
          );
        }
      } else if (widget.actionChoice == ActionChoice.randomGroups) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RandomGroupsFromGroup(players: selectedPlayersList, option: RandomGroupAction.customGroup),
          ),
        );
      } else if (widget.actionChoice == ActionChoice.randomPlayer) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RandomPlayerFromGroup(players: selectedPlayersList),
          ),
        );
      } else if (widget.actionChoice == ActionChoice.randomMatches) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RandomGroupsFromGroup(players: selectedPlayersList, option: RandomGroupAction.fixedGroup),
          ),
        );
      }
    } else {
      CustomToast.show(context, "Keine Spieler ausgewählt!");
      print('No players selected');
    }
  }
}

class SelectablePlayers extends StatefulWidget {
  final List<Player> players;
  final List<bool> selectedPlayers;
  final List<Group> groups;

  SelectablePlayers(this.players, this.selectedPlayers, this.groups);

  @override
  _SelectablePlayersState createState() => _SelectablePlayersState();
}

class _SelectablePlayersState extends State<SelectablePlayers> {
  List<bool> selectedGroups = []; 

  @override
  void initState() {
    super.initState();
    selectedGroups = List.filled(widget.groups.length, false); 
  }

  void _handleGroupSelection(int groupIndex, bool isSelected) {
    setState(() {
      selectedGroups[groupIndex] = isSelected;
      widget.groups[groupIndex].player.forEach((playerId) {
        int playerIndex = widget.players.indexWhere((player) => player.id == playerId);
        if (playerIndex != -1) {
          widget.selectedPlayers[playerIndex] = isSelected;
        }
      });
    });
  }

@override
Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
      Expanded( 
        child: ListView(
          children: <Widget>[
            ...widget.groups.asMap().entries.map((entry) {
              int groupIndex = entry.key;
              Group group = entry.value;
              return ListTile(
                title: Text("Gruppe: ${group.name}", style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Checkbox(
                  value: selectedGroups[groupIndex],
                  onChanged: (value) {
                    _handleGroupSelection(groupIndex, value!);
                  },
                ),
              );
            }).toList(),
            ...widget.players.asMap().entries.map((entry) {
              int playerIndex = entry.key;
              Player player = entry.value;
              return ListTile(
                title: Text(player.name),
                leading: Checkbox(
                  value: widget.selectedPlayers[playerIndex],
                  onChanged: (value) {
                    setState(() {
                      widget.selectedPlayers[playerIndex] = value!;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    ],
  );
}

}

enum ActionChoice{
  randomGroups,
  randomPlayer,
  randomMatches,
  minigame,
}
