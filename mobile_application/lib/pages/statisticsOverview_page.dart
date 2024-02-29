import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class StatisticsOverviewPage extends StatelessWidget {
  const StatisticsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Statistiken',
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomElevatedButton.customButton('Elo Rating Verlauf', context: context, route: '/playerelochartpage'),
              SizedBox(height: 20), 
              CustomElevatedButton.customButton('Top Elo Zuwachs', context: context, route: '/statisticselogainpage'),
              SizedBox(height: 20), 
            ],
          ),
        ],
      ),
    );
  }
}
