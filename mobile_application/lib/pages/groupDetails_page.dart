import 'package:flutter/material.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile_application/globalVariables.dart';

// Global lists
List<Group> allGroups = groups; // Your list of groups
List<Player> allPlayers = player; // Your list of all players

class GroupDetailsPage extends StatefulWidget {
  final int groupIndex;

  GroupDetailsPage({Key? key, required this.groupIndex}) : super(key: key);

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  late List<bool> _selectedPlayers;
  late Group _group;

  @override
  void initState() {
    super.initState();
    _group = allGroups[widget.groupIndex];
    _selectedPlayers = List.generate(_group.player.length, (_) => true);
  }

  void _deleteGroup() async {
    // Implement your delete group HTTP request here
  }

  void _saveSelectedPlayers() async {
    // Prepare your HTTP request with selected player IDs here
    List<int> selectedPlayerIds = _group.player
        .asMap()
        .entries
        .where((entry) => _selectedPlayers[entry.key])
        .map((entry) => entry.value)
        .toList();
    
    // Implement your save selected players HTTP request here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteGroup,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _group.player.length,
        itemBuilder: (context, index) {
          Player player = allPlayers.firstWhere((p) => p.id == _group.player[index]);
          return CheckboxListTile(
            title: Text(player.name),
            value: _selectedPlayers[index],
            onChanged: (bool? value) {
              setState(() {
                _selectedPlayers[index] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveSelectedPlayers,
        child: Icon(Icons.save),
        tooltip: 'Save Selected Players',
      ),
    );
  }
}
