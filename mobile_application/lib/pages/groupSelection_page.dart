import 'package:flutter/material.dart';
import 'package:mobile_application/globalVariables.dart';
import 'package:mobile_application/pages/randomPlayerFromGroup_page.dart';



class GroupSelectionPage extends StatefulWidget {

  GroupSelectionPage({
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
                              // Handle button tap for each user, e.g., navigate to their profile.
                              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(userNames[index]));

                              //navigate to PlayerDetails, handle name change.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RandomPlayerFromGroup(group: groups[index]),
                                ),
                              );
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
