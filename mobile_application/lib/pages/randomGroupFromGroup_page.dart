import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'dart:math';
import 'package:mobile_application/entities/player.dart';

class RandomGroupsFromGroup extends StatefulWidget {

  final List<Player> players;
  final RandomGroupAction option; // 1 for fixed group size and number, 2 for as many groups as possible with size 2

  const RandomGroupsFromGroup({Key? key, required this.players, required this.option}) : super(key: key);

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
        title: widget.option == RandomGroupAction.customGroup ? 'Zufällige Gruppen generieren' : 'Zufällige Paarungen generieren',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (widget.option == RandomGroupAction.customGroup) ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Anzahl der Gruppen'),
                    initialValue: _numberOfGroups.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _numberOfGroups = int.tryParse(value) ?? _numberOfGroups;
                    }),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Gruppengröße'),
                    initialValue: _groupSize.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {
                      _groupSize = int.tryParse(value) ?? _groupSize;
                    }),
                  ),
                ],
                SizedBox(height: 20),
                Center( 
                  child: CustomElevatedButton(
                    onPressed: _generateSubGroups,
                    text: widget.option == RandomGroupAction.customGroup ? 'Generiere Gruppen' : 'Generiere Paarungen',
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
  List<List<Player>> newSubGroups = []; 
  final random = Random();

  // copy of the widget's players list to further modify it
  List<Player> playersToDistribute = List.from(widget.players);

  if (widget.option == RandomGroupAction.customGroup) {
    // Option 1: Fixed number of groups with specified size
    while (playersToDistribute.isNotEmpty) {
      List<Player> group = [];
      for (int i = 0; i < _groupSize && playersToDistribute.isNotEmpty; i++) {
        int randomIndex = random.nextInt(playersToDistribute.length);
        group.add(playersToDistribute.removeAt(randomIndex));
      }
      if (group.isNotEmpty) {
        newSubGroups.add(group);
      }
    }
  } else if (widget.option == RandomGroupAction.fixedGroup) {
    // Option 2: As many groups as possible with 2 players each
    while (playersToDistribute.length >= 2) {
      List<Player> pair = [];
      for (int i = 0; i < 2; i++) {
        int randomIndex = random.nextInt(playersToDistribute.length);
        pair.add(playersToDistribute.removeAt(randomIndex));
      }
      newSubGroups.add(pair);
    }
  }

  setState(() {
    subGroups = newSubGroups;
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
                widget.option == RandomGroupAction.customGroup ? 'Gruppe ${groupIndex + 1}' : 'Paarung ${groupIndex + 1}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Divider(),
              ...group.map((player) => ListTile(
                    title: Text(player.name),
                    subtitle: Text('Elo: ${player.currentElo}'),
                  )),
            ],
          ),
        ),
      );
    }).toList();
  }
}

enum RandomGroupAction{
  customGroup,
  fixedGroup
}