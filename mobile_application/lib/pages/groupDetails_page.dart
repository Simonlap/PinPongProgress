import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/elements/customAlertDialog.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/playerSelectionUpdateGroup_page.dart';

List<Group> allGroups = groups; 
List<Player> allPlayers = player;

class GroupDetailsPage extends StatefulWidget {
  final int groupIndex;
  final VoidCallback onDelete;
  final Function(bool, List<int>) onSave;

  const GroupDetailsPage({
    Key? key,
    required this.onDelete,
    required this.groupIndex,
    required this.onSave,
  }) : super(key: key);

  @override
  _GroupDetailsPageState createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  late Group _group;
  late bool _changed;
  late List<int> _playerIds;

  @override
  void initState() {
    super.initState();
    _group = allGroups[widget.groupIndex];
    _playerIds = List.from(_group.player);
    _changed = false;
  }

  void _showDeleteConfirmationDialog() {
    showConfirmationDialog(
      context: context,
      title: 'Gruppe Löschen',
      message: 'Möchtest du diese Gruppe wirklich löschen?',
      onConfirm: _deleteGroup,
      onCancel: () {},
    ).then((confirmed) {
      if (confirmed) {
        _deleteGroup();
      }
    });
  }

  void _deleteGroup() {
    widget.onDelete();
    Navigator.pop(context);
  }

  void _saveSelectedPlayers() {
    if (_changed) {
      widget.onSave(true, _playerIds);
    } else {
      widget.onSave(false, []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gruppendetails', actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteConfirmationDialog,
          ),
        ],),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _playerIds.length,
              itemBuilder: (context, index) {
                Player player = allPlayers.firstWhere(
                  (p) => p.id == _playerIds[index], 
                  orElse: () => Player(id: -1, name: 'Unknown', eloRatings: [])
                );
                int currentElo = player.currentElo;

                return ListTile(
                  title: Text(player.name),
                  subtitle: Text('Elo: $currentElo'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerSelectionUpdateGroupPage(
                          initialSelectedPlayers: _playerIds,
                          groupId: _group.id,
                          onUpdate: (bool updated, List<int> playerIds) {
                            if (updated) {
                              setState(() {
                                _changed = true;
                                _playerIds = playerIds;
                              });
                              _saveSelectedPlayers();
                            }
                          },
                        ),
                      ),
                    );
                    if (result != null && result is List<int>) {
                      setState(() {
                        _changed = true;
                        _playerIds = result;
                      });
                    }
                  },
                  text: 'Spieler bearbeiten',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
