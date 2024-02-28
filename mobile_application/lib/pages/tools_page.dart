import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/pages/groupSelection_page.dart';

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
      appBar: AppBar(
        title: Text('Tools'),
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
                title: 'Anwesenheitsliste',
                onPressed: () {
                  // TODO:
                },
              ),
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Zufälligen Spieler auswählen',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupSelectionPage(option: 1),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              _buildToolButton(
                context: context,
                title: 'Zufällige Gruppe generieren',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupSelectionPage(option: 2),
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
                      builder: (context) => GroupSelectionPage(option: 3),
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
