import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  Widget _buildToolButton({
    required BuildContext context,
    required String title,
    VoidCallback? onPressed,
    String? route,
    int? option,
  }) {
    return CustomElevatedButton.customButton(
      title,
      onPressed: onPressed ??
          () {
            Navigator.pushNamed(
              context,
              route!,
              arguments: option,
            );
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tools',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Gruppen Verwalten',
                route: '/managegroupspage',
              ),
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Zufälligen Spieler auswählen',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayersSelectionPage(actionChoice: ActionChoice.randomPlayer),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Zufällige Gruppen generieren',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayersSelectionPage(actionChoice: ActionChoice.randomGroups),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Zufällige Paarungen',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayersSelectionPage(actionChoice: ActionChoice.randomMatches),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
