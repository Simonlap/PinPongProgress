import 'package:flutter/material.dart';
import 'package:mobile_application/elements/customElevatedButton.dart';
import 'dart:math';

import 'package:mobile_application/entities/minigamesEnum.dart';
import 'package:mobile_application/pages/gameExplanation_page.dart';

class ImperialTablePage extends StatefulWidget {
  const ImperialTablePage({Key? key}) : super(key: key);

  @override
  _ImperialTablePageState createState() => _ImperialTablePageState();
}

class _ImperialTablePageState extends State<ImperialTablePage> {
  String? selectedText;
  final List<String> variations = [
    "Mit der falschen Hand spielen",
    "Den Ball erst einmal auf dem Boden aufkommen lassen",
    "PingPong (den Ball erst auf der eigenen Tischhälfte aufkommen lassen)",
    "Auf einem Bein spielen",
    "Doppelball (zwei Bälle gleichzeitig im Spiel)",
    "Mit der Handfläche statt mit dem Schläger spielen",
    "Rückwärts spielen (dem Tisch den Rücken zukehren)",
    "Immer abwechselnd Vorhand- und Rückhandschläge",
    "Zeitlimit pro Punkt (muss innerhalb von 10 Sekunden gewonnen werden)",
    "Schläger in der Luft tauschen (nach jedem Schlag den Schläger in die andere Hand nehmen)",
    "Jeder Spieler muss vor dem Schlag einmal um sich selbst drehen",
    "Punkt nur gültig, wenn der Ball die Kante des Tisches trifft",
    "Jeder Punkt muss mit einem Aufschlag gewonnen werden",
    "Ball muss vor dem Überqueren des Netzes zweimal auf der eigenen Seite aufkommen",
    "Rallye, bei der der Ball jedes Mal höher als 2 Meter gespielt werden muss",
    "Nur Unterschnitt oder nur Topspin",
    "Jeder Spieler muss vor jedem Schlag einen Satz sagen (z.B. Ich liebe Tischtennis)",
    "Mit der flachen Hand auf den Ball schlagen, statt den Schläger zu benutzen",
    "Punkte zählen nur, wenn der Ball auf einer bestimmten Hälfte des gegnerischen Feldes landet",
    "Rallye, bei der der Ball bei jedem Schlag seitlich gedreht werden muss",
    "Spielen, indem man den Schläger mit beiden Händen hält",
    "Spielen, indem man den Schläger hinter dem Rücken hält",
    "Punkte zählen nur, wenn der Ball vom Boden abprallt und dann über das Netz fliegt",
    "Ball muss vor dem Überqueren des Netzes von der Wand abprallen",
    "Rallye, bei der der Ball jedes Mal einen vorgegebenen Bereich auf dem Tisch treffen muss",
    "Rallye, bei der der Ball abwechselnd hart und dann wieder weich gespielt werden muss",
    "Punkte zählen nur, wenn der Ball mit einem Volley-Schlag (aus der Luft) getroffen wird",
    "Mit einem umgedrehten Schläger spielen (Griff nach oben)",
    "Jeder Spieler muss vor dem Schlag einen Sprung mit Drehung machen",
    "Mit einem Schläger spielen, der verkehrt herum (mit der Schlagfläche nach unten) gehalten wird",
    "Spielen, während man auf einem Bein hüpft", 
    "Jeder Punkt muss mit einem Trickshot (z.B. hinter dem Rücken, durch die Beine) gewonnen werden",
    "Jeder Spieler muss vor dem Schlag einen Hampelmann machen",
    "Spielen, indem man den Ball erst in die Luft schlägt, bevor man ihn schlägt (2 Berührungen erlaubt)",
    "Spielen, indem man den Ball mit dem Schläger unter dem Bein durchspielt",
  ];

  void _selectRandomText() {
    final random = Random();
    int randomIndex = random.nextInt(variations.length);

    setState(() {
      selectedText = variations[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Minigame.kaisertisch.title),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameExplanationPage(Minigame.kaisertisch),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (selectedText != null)
                Card(
                  elevation: 4.0, 
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      selectedText!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 24),
              CustomElevatedButton(
                onPressed: _selectRandomText,
                text: 'Neue Variation',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
