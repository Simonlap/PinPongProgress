import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customAppBar.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';
import 'package:mobile_application/pages/imperialTable_page.dart';
import 'package:mobile_application/pages/playerSelection_page.dart';

class MinispielePage extends StatelessWidget {
  const MinispielePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Minispiele',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: 
            Minigame.values.map((game) => Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CustomElevatedButton.customButton(
                game.title,
                onPressed: () {
                  if (game == Minigame.siebenerTisch || game == Minigame.alleGegenAlle) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayersSelectionPage(selectedMinigame: game, actionChoice: ActionChoice.minigame,),
                      ),
                    );
                  } else if (game == Minigame.kaisertisch) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImperialTablePage(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameExplanationPage(game),
                      ),
                    );
                  }
                },
              ),
            )).toList(),
        ),
      ),
    );
  }
}
