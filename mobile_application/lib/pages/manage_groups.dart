import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/globalVariables.dart';
import 'dart:convert';

import 'package:mobile_application/pages/groupDetails_page.dart';

class ManageGroupsPage extends StatefulWidget {
  const ManageGroupsPage({Key? key});

  @override
  _ManageGroupsState createState() => _ManageGroupsState();
}

class _ManageGroupsState extends State<ManageGroupsPage> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> deleteGroup(index) async {

    final url = Uri.parse(apiUrl + '/api/userdata/group/' + groups[index].id.toString());
    print("Group Index" + groups[index].id.toString());
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      }
    );

    if (response.statusCode == 200) {
      groups.removeAt(index);
      setState(() {
      });
      
      print('Group deleted successfully');
  
    } else {

      print('Failed to delete group. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateGroup(index, newPlayers) async {
    final url = Uri.parse('$apiUrl/api/userdata/group/' + groups[index].id.toString() + '/update');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': jwtToken!,
      },
      body: jsonEncode({
        'newPlayers': newPlayers
      }),
    );

    print(newPlayers);

    if (response.statusCode == 200) {
      setState(() {
        groups[index] = Group.fromJson(json.decode(response.body));
      });

      print('Group updated successfully');
  
    } else {
      print('Failed to update group. Status code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Gruppen verwalten',
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
                          child: CustomElevatedButton.customButton(
                            groups[index].name,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupDetailsPage(
                                    groupIndex: index,
                                    onDelete: () {
                                      deleteGroup(index);
                                    },
                                    onSave: (changed, newPlayers) {
                                      if (changed) {
                                        updateGroup(index, newPlayers);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: CustomElevatedButton.customButton(
                  'Add Group',
                  onPressed: () {
                    Navigator.pushNamed(context, '/playerselectiongrouppage');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
