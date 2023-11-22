import 'package:flutter/material.dart';
import 'package:test_application/entities/player.dart';

class PlayerDetails extends StatefulWidget {
  final Player player;
  final Function(String) onNameChanged;

  const PlayerDetails({
    Key? key,
    required this.player,
    required this.onNameChanged,
  }) : super(key: key);

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.player.name);
  }

  void _toggleEditing() {
    widget.player.name = _nameController.text; 
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _acceptChanges() {
    // Save changes and notify parent
    widget.onNameChanged(_nameController.text);
    if (_isEditing) {
      _toggleEditing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Details'),
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
                  onPressed: _toggleEditing,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Elo: ${widget.player.elo}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _acceptChanges,
              child: Text('Accept Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
