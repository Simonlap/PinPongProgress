enum Minigame {
  alleGegenAlle,
  kaisertisch,
  siebenerTisch,
  achtZuAcht,
  tikTakToe,
  menschAergereDichNicht,
}

extension MiniGameExtension on Minigame {
  String get title {
    switch (this) {
      case Minigame.alleGegenAlle:
        return 'Alle gegen Alle';
      case Minigame.kaisertisch:
        return 'Kaisertisch';
      case Minigame.siebenerTisch:
        return '7er Tisch';
      case Minigame.achtZuAcht:
        return 'Acht zu Acht';
      case Minigame.tikTakToe:
        return 'Tik Tak Toe';
      case Minigame.menschAergereDichNicht:
        return 'Mensch Ärgere Dich Nicht!';
      default:
        return 'Unknown Game';
    }
  }

  String get explanation {
    switch (this) {
      case Minigame.alleGegenAlle:
        return "Alle gegen Alle ist ein Spielmodus, in dem jeder Spieler für sich selbst kämpft. "
            "Durch leichte Zufälle spielt zunächst jeder gegen jeden, da die Tabelle anfangs noch nicht mit Daten gefüllt ist. "
            "Je nach Spielausgang berechnet sich dann allerdings im Laufe des Spiels eine Veränderung an der Elo eines Spielers, die entscheidend für die Spielpaarungen im nächsten Spiel sind. "
            "Die Elo ähnelt dabei der echten TTR, jedoch zählt hier auch die Höhe des Ergebnisses!"
            "Dadurch ist es möglich, dass zwar alle Spieler prinzipiell in einer Gruppe sind, die stärkeren Spieler allerdings später eher gegen die stärkeren Spieler spielen und umgekehrt."
            "\n\nEin Spaß für den ganzen Verein!";
      case Minigame.kaisertisch:
        return "Kaisertisch ist eher als Abschlussspiel eines Kindertrainings gedacht, um noch mehr Spaß am Tischtennis zu bekommen. \n\n"
            "Die Tische werden zunächst gedanklich in einer Linie sortiert. "
            "Am einen Ende der Linie ist der 'Kaisertisch', am anderen Ende der Linie ist der 'Loosertisch'. "
            "Anfangs verteilen sich die Spieler einfach zufällig auf die Tische. (Dazu kann gerne auch die Tools Funktion genutzt werden, die zufällige Paarungen ermöglicht)"
            "Gespielt wird ab dem Zeitpunkt, wo der Trainer 'Start' ruft, und Ende ist, sobald der Trainer 'Stopp' ruft. Empfohlen wird hier eine Zeit von 1-3 Minuten."
            "Sobald 'Stopp' ertönt, geht der Gewinner einen Tisch in Richtung 'Kaisertisch', der Verlierer des jeweiligen Tisches einen Tisch in Richtung 'Loosertisch'. "
            "Dadurch sortieren sich die Spieler der gleichen Spielstärke tendentiell in der gleichen Tischregion.\n\n "
            "Diese App ermöglicht es nun, weitere Spielvariationen in das Kaisertischturnier einzubringen. "
            "Zum Beispiel wird eine Runde nur mit 'Elefantengriff' gespielt, die nächste Runde mit der falschen Hand. "
            "Und versprochen: Der Elefantengriff ist nicht nur beim Zuschauen witzig! :) "
            "Der Kreativität sind hier natürlich keine Grenzen gesetzt und der Trainer kann gerne noch eigene Ideen mit einfließen lassen! "
            "Viel Spaß!";
      case Minigame.siebenerTisch:
        return "Um den siebener Tisch zu spielen, ist nicht viel nötig. "
            "Das schöne ist, dass auch die schlechteren Spieler nach etwas Zeit immer die Chance auf einen Sieg haben.  \n\n"
            "Es verteilen sich anfangs alle Spieler zufällig an die Tische (Hier kann gerne unsere Hilfe im Tools Menü genutzt werden, um zufällige Paarungen zu erstellen.). "
            "Gespielt wird ab dem Zeitpunkt, wo der Trainer das Spiel freigibt."
            "Der Spieler, der in einer Partie nun 7 Punkte erzielt hat, rennt zum Trainer, und berichtet von seinem Erfolg. "
            "Der Verlierer bleibt nun allerdings am jeweiligen Tisch stehen und behält seine Punkte aus dem Spiel für das nächste Spiel. \n\n"
            "Spielt Johannes also gegen Marie und Marie gewinnt mit 7:5, so so startet Johannes mit 5:0 in das nächste Spiel. "
            "Marie rennt zum Trainer und lässt sich einen Punkt gutschreiben. Sie wartet, bis jemand anderes ebenfalls mit seinem Spiel fertig wird und spielt nun gegen den Verlierer dieses Tisches. "
            "Diese Person startet ebenfalls mit dem Punktestand aus dem vorherigen Spiel. "
            "Der Trainer zählt die gewonnen Spiele des Spielers mit Hilfe der Strichliste in unserer App. "
            "Um den Trainer nicht zu verwirren mit zu vielen Spielern (Hab ich für Marie schon den Strich gemacht???), wird hier auch die Uhrzeit des letzten gewonnenen Spiels angezeigt. "
            "Viel Spaß beim Spielen! "
            ;
      case Minigame.achtZuAcht:
        return "Dies ist ein sehr einfacher Spielmodus, der sogar ohne weitere Funktionen der App auskommt. \n\n"
            "Die Spieler starten das Spiel mit einem Punktestand von 8:8. "
            "In unserem Beispiel spielen Jonathan gegen Marie. "
            "Gewinnt Jonathan den ersten Punkt, wird ihm einer gut geschrieben und Marie einen Punkt abgezogen. "
            "Der neue Spielstand ist also 9:7. "
            "Gespielt wird solange, bis einer der beiden Spieler 16 Punkte hat.\n\n"
            "Viel Erfolg! "
        ;
      case Minigame.tikTakToe:
        return "Hier folgt nun ein bei den Spielern sehr beliebtes Minispiel! \n\n"
            "Aufgebaut wird vom Trainer ein 3x3 Feld, an dem TikTakToe gespielt wird. "
            "Dieses Feld kann beispielsweise durch Stöcke oder Seile aufgebaut werden und Striche und Kreuze können durch z.B. durch Ringe visualisiert werden. \n\n"
            "Die Spieler werden nun an maximal 4 Tischen mit möglichst gleicher Spielstärke verteilt. "
            "Es gibt 2 Teams, die jeweils aus einer Person von jedem Tisch bestehen. "
            "Am einfachsten ist es, Spieler auf einer Seite in ein Team einzuordnen. "
            "Die Spieler spielen bis zum Punktstand von 5 gegeneinander. "
            "Der Gewinner des Tisches kann nun zum aufgebauten 3x3 Feld rennen und sein Kreis oder Kreuz beliebig setzen. \n\n"
            "Nachdem er dieses Kreuz gesetzt hat, rennt er wieder zum Tisch und spielt nochmals gegen seinen Gegner bis 5. "
            "Gespielt wird nun mit normalen TikTokToe regeln, 3 in einer Reihe gewinnt! "
            "\n\nTipp: Teams gerne durchwechseln, denn die Runden gehen schnell vorbei! "
            "Viel Spaß!"
        ;
      case Minigame.menschAergereDichNicht:
        return "Hierzu wird ein klassisches Mensch-Ärgere-Dich-Nicht-Brettspiel benötigt. "
            "\n\nDie Spieler werden in vier verschiedene Teams aufgeteilt. "
            "Außerdem gibt es sechs verschiedene Übungen, die nummeriert werden und abgearbeitet werden müssen, nachdem man die entsprechende Augenzahl gewürfelt hat. "
            "Nachdem die Übung erledigt ist, wird die Spielfigur auf dem Brettspiel bewegt und erneut gewürfelt. "
            "Gewonnen hat das Team, welches als erstes im Ziel angekommen ist!\n\n "
            "Übungen könnten beispielsweise folgende sein: \n"
            "Auf einer Bank mit dem Ball und Schläger balancieren. \n"
            "Balleimer: Jedes Teammitglied muss 10 Topspin-Bälle spielen. \n"
            "Bierpong Becher als Pyramide aufbauen, und diese müssen mit dem TT-Ball abgeworfen werden. \n"
            "Angabenübung: Ein Seil auf dem Tisch plazieren, und die Teammitglieder müssen hinter diesem Seil 5 Aufschläge plazieren. \n"
            "3 Runden durch die Halle laufen. \n"
            "... \n\n"
            "Tipp: verwendet nur eine Spielfigur, und das Rauswerfen wird verboten. Außerdem muss keine sechs am Anfang geworfen werden. \n"
            "\nViel Spaß und ... ärgert euch nicht! :-)"
        ;
      default:
        return "Das hier ist ein super tolles Minigame. Mach dich bereit!";
    }
  }

  int get id {
    return this.index;
  }
}
