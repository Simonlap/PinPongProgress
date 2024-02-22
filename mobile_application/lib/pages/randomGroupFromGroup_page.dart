import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/globalVariables.dart';

class RandomGroupsFromGroup extends StatefulWidget {
  final Group group;

  const RandomGroupsFromGroup({Key? key, required this.group}) : super(key: key);

  @override
  _RandomGroupsFromGroupState createState() => _RandomGroupsFromGroupState();
}

class _RandomGroupsFromGroupState extends State<RandomGroupsFromGroup> {
  final _formKey = GlobalKey<FormState>();
  int _numberOfGroups = 2;
  int _groupSize = 2;
  List<List<Player>> subGroups = [];

  void _generateSubGroups() {
    final random = Random();
    List<int> playerIds = List.from(widget.group.player);
    subGroups.clear();

    for (int i = 0; i < _numberOfGroups; i++) {
      List<Player> group = [];
      for (int j = 0; j < _groupSize; j++) {
        if (playerIds.isNotEmpty) {
          int randomIndex = random.nextInt(playerIds.length);
          int playerId = playerIds.removeAt(randomIndex);
          Player? selectedPlayer = player.firstWhere((element) => element.id == playerId);
          if (selectedPlayer != null) {
            group.add(selectedPlayer);
          }
        }
      }
      if (group.isNotEmpty) {
        subGroups.add(group);
      }
    }

    setState(() {}); // Rebuild the UI to display the new subgroups
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Random Groups from ${widget.group.name}'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of Groups'),
                initialValue: '2',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _numberOfGroups = int.tryParse(value) ?? 2;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Group Size'),
                initialValue: '2',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _groupSize = int.tryParse(value) ?? 2;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateSubGroups,
                child: Text('Generate Groups'),
              ),
              SizedBox(height: 20),
              ...subGroups.asMap().entries.map((entry) {
                int groupIndex = entry.key;
                List<Player> group = entry.value;
                return Card(
                  elevation: 4.0, // Adds shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Group ${groupIndex + 1}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        ...group.map((player) => ListTile(
                              title: Text(player.name),
                              subtitle: Text('ELO: ${player.currentElo}'), // Assuming a 'currentElo' property exists
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    ),
  );
}
}