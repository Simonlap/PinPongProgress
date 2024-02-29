import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAlertDialog.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/entities/player.dart';

class PlayerDetailsPage extends StatefulWidget {
  final Player player;
  final Function(String) onNameChanged;
  final VoidCallback onDelete;

  const PlayerDetailsPage({
    Key? key,
    required this.player,
    required this.onNameChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetailsPage> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.player.name);
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _acceptChanges() {
    // Save changes and notify parent
    if (widget.player.name != _nameController.text) {
      widget.player.name = _nameController.text;
      widget.onNameChanged(_nameController.text);
    }
    _toggleEditing();
  }

  void _deletePlayer() {
    widget.onDelete();
    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog() {
    showConfirmationDialog(
      context: context,
      title: 'Spieler löschen',
      message: 'Möchtest du diesen Spieler wirklich löschen?',
      onConfirm: _deletePlayer,
      onCancel: () {},
    ).then((confirmed) {
      if (confirmed) {
        _deletePlayer();
      }
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Spieler Details',
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteConfirmationDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name: ',
                  style: TextStyle(fontSize: 18),
                ),
                _isEditing
                    ? Expanded(
                        child: TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : Expanded(
                        child: Text(
                          widget.player.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                IconButton(
                  icon: Icon(_isEditing ? Icons.done : Icons.edit),
                  onPressed: _acceptChanges,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Elo: ${widget.player.currentElo}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
