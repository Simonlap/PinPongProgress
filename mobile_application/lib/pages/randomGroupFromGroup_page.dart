import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'dart:math';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/globalVariables.dart';

class RandomGroupsFromGroup extends StatefulWidget {
  final Group group;
  final int option; // 1 for fixed group size and number, 2 for as many groups as possible with size 2

  const RandomGroupsFromGroup({Key? key, required this.group, required this.option}) : super(key: key);

  @override
  State<RandomGroupsFromGroup> createState() => _RandomGroupsFromGroupState();
}

class _RandomGroupsFromGroupState extends State<RandomGroupsFromGroup> {
  final _formKey = GlobalKey<FormState>();
  int _numberOfGroups = 2;
  int _groupSize = 2;
  List<List<Player>> subGroups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Zufällige Gruppen aus ${widget.group.name}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (widget.option == 1) ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Number of Groups'),
                    initialValue: _numberOfGroups.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _numberOfGroups = int.tryParse(value) ?? _numberOfGroups;
                    }),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Group Size'),
                    initialValue: _groupSize.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _groupSize = int.tryParse(value) ?? _groupSize;
                    }),
                  ),
                ],
                SizedBox(height: 20),
                Center( // Wrap the button with Center
                  child: CustomElevatedButton(
                    onPressed: _generateSubGroups,
                    text: widget.option == 1 ? 'Generiere Gruppen' : 'Generiere Paarungen',
                  ),
                ),
                SizedBox(height: 20),
                ..._buildGroupCards(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void _generateSubGroups() {
  List<int> playerIds = List.from(widget.group.player); // Assuming this is a list of player IDs
  List<List<Player>> subGroups = [];
  final random = Random();

  // Filter out the players based on the IDs in playerIds
  List<Player> filteredPlayers = player.where((player) => playerIds.contains(player.id)).toList();

  if (widget.option == 1) {
    // Option 1: Fixed number of groups with specified size
    while (filteredPlayers.isNotEmpty) {
      List<Player> group = [];
      for (int i = 0; i < _groupSize && filteredPlayers.isNotEmpty; i++) {
        // Remove a random player and add to the group
        int randomIndex = random.nextInt(filteredPlayers.length);
        group.add(filteredPlayers.removeAt(randomIndex));
      }
      if (group.isNotEmpty) {
        subGroups.add(group);
      }
    }
  } else if (widget.option == 2) {
    // Option 2: As many groups as possible with 2 players each
    while (filteredPlayers.length >= 2) {
      List<Player> pair = [];
      for (int i = 0; i < 2; i++) {
        // Remove a random player and add to the pair
        int randomIndex = random.nextInt(filteredPlayers.length);
        pair.add(filteredPlayers.removeAt(randomIndex));
      }
      subGroups.add(pair);
    }
  }

  // Update the state with the new sub-groups
  setState(() {
    this.subGroups = subGroups;
  });
}




  List<Widget> _buildGroupCards() {
    return subGroups.asMap().entries.map((entry) {
      int groupIndex = entry.key;
      List<Player> group = entry.value;
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.option == 1 ? 'Gruppe ${groupIndex + 1}' : 'Paarung ${groupIndex + 1}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Divider(),
              ...group.map((player) => ListTile(
                    title: Text(player.name),
                    subtitle: Text('ELO: ${player.currentElo}'),
                  )),
            ],
          ),
        ),
      );
    }).toList();
  }
}
