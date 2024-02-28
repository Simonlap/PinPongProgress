import 'package:flutter/material.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/randomGroupFromGroup_page.dart';
import 'package:mobile_application/pages/randomPlayerFromGroup_page.dart';



class GroupSelectionPage extends StatefulWidget {

  final int option;

  GroupSelectionPage({
    required this.option,
    Key? key,
  }) : super(key: key);

  @override
  _GroupSelectionPageState createState() => _GroupSelectionPageState();
}

class _GroupSelectionPageState extends State<GroupSelectionPage> {
  late List<bool> selectedPlayers; 

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Group',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return Padding( 
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(0, 100),
                              ),
                            ),
                            onPressed: () {
                              if (widget.option == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RandomPlayerFromGroup(group: groups[index]),
                                  ),
                                );
                              } else if (widget.option == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RandomGroupsFromGroup(group: groups[index], option: 1),
                                  ),
                                );
                              } else if (widget.option == 3) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RandomGroupsFromGroup(group: groups[index], option: 2)));
                              }
                            },
                            child: Text(
                              groups[index].name,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
