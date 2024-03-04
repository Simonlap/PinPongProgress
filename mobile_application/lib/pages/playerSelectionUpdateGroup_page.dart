import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart' as globalVariables;

// Assuming you have a way to update the group, import necessary files
// import 'path_to_your_backend_service_or_state_management_solution';

class PlayerSelectionUpdateGroupPage extends StatefulWidget {
  final List<int> initialSelectedPlayers;
  final int groupId; // Assuming you need an identifier to update the group
  final Function(bool updated, List<int> playerIds) onUpdate;

  PlayerSelectionUpdateGroupPage({
    Key? key,
    required this.initialSelectedPlayers,
    required this.groupId,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _PlayerSelectionUpdateGroupState createState() => _PlayerSelectionUpdateGroupState();
}

class _PlayerSelectionUpdateGroupState extends State<PlayerSelectionUpdateGroupPage> {
  late List<bool> selectedPlayers;

  @override
  void initState() {
    super.initState();
    selectedPlayers = globalVariables.player.map((p) => widget.initialSelectedPlayers.contains(p.id)).toList();
  }

  void _updateGroup() {
    List<int> selectedPlayerIds = [];
      for (int i = 0; i < globalVariables.player.length; i++) {
        if (selectedPlayers[i]) {
          selectedPlayerIds.add(globalVariables.player[i].id);
        }
      }
      widget.onUpdate(true, selectedPlayerIds);
      Navigator.pop(context);
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar (
        title: 'Spieler bearbeiten',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Text(
              'Wer ist in der Gruppe?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Expanded( 
            child: SelectablePlayers(globalVariables.player, selectedPlayers),
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: _updateGroup,
            text: 'Speichern',
          ),
        ],
      ),
    );
  }
}

class SelectablePlayers extends StatefulWidget {
  final List<Player> players;
  final List<bool> selectedPlayers;

  SelectablePlayers(this.players, this.selectedPlayers);

  @override
  _SelectablePlayersState createState() => _SelectablePlayersState();
}

class _SelectablePlayersState extends State<SelectablePlayers> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.players.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(widget.players[i].name),
          leading: Checkbox(
            value: widget.selectedPlayers[i],
            onChanged: (bool? value) {
              setState(() {
                widget.selectedPlayers[i] = value!;
              });
            },
          ),
        );
      },
    );
  }
}
