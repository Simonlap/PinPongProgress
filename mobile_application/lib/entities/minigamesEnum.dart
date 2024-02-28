enum Minigame {
  alleGegenAlle,
  kaisertisch,
  siebenerTisch,
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
      default:
        return 'Unknown Game';
    }
  }

  String get explanation {
    switch (this) {
      case Minigame.alleGegenAlle:
        return "Alle gegen Alle ist ein Spielmodus, in dem jeder Spieler für sich selbst kämpft. "
            "Durch leichte Zufälle spielt zunächst jeder gegen jeden, da die Tabelle anfangs noch nicht mit Daten gefüllt ist. "
            "Je nach Spielausgang berechnet sich dann allerdings im Laufe des Spiels eine Veränderung an der Elo eines Spielers, die entscheident für die Spielpaarungen im nächsten Spiel sind. "
            "Dadurch ist es möglich, dass zwar alle Spieler prinzipiell in einer Gruppe sind, die stärkeren allerdings später eher gegen die stärkeren Spieler spielen und umgekehrt."
            "\n\nEin Spaß für den ganzen Verein!";
      case Minigame.kaisertisch:
        return "Kaisertisch ist eher als Abschlussspiel eines Kindertrainings gedacht, um spielerisch Spaß am Tischtennis zu bekommen. \n\n"
            "Die Tische werden zunächst gedanklich in einer Linie sortiert. "
            "Am einen Ende der Linie ist der 'Kaisertisch', am anderen Ende der Linie ist der 'Loosertisch'. "
            "Anfangs verteilen sich die Spieler einfach zufällig auf die Tische. (Dazu kann gerne auch die Tools Funktion genutzt werden, die zufällige Paarungen ermöglicht)"
            "Gespielt wird dann ab dem Zeitpunkt, wo der Trainer 'Start' ruft, und Ende ist, sobald der Trainer 'Stopp' ruft. Empfohlen wird hier eine Zeit von 1-3 Minuten."
            "Sobald 'Stopp' ertönt, geht der Gewinner einen Tisch in Richtung 'Kaisertisch', der Verlierer des jeweiligen Tisches einen Tisch in Richtung 'Loosertisch'. "
            "Dadurch sortieren sich die Spieler der gleichen Spielstärke tendentiell in der gleichen Tischregion.\n\n "
            "Diese App ermöglicht es nun, weitere Spielvariationen in das Kaisertischturnier einzubringen. "
            "Zum Beispiel wird eine Runde nur mit 'Elefantengriff' gespielt, die nächste Runde mit der falschen Hand. "
            "Und versprochen: Der Elefantengriff ist nicht nur beim Zuschauen witzig anzusehen! :) "
            "Der Kreativität sind hier natürlich keine Grenzen gesetzt und der Trainer kann gerne noch eigene Ideen mit einfließen lassen! "
            "Viel Spaß!";
      case Minigame.siebenerTisch:
        return "Um den siebener Tisch zu spielen, ist nicht viel nötig. "
            "Das schöne ist, dass auch die schlechteren Spieler nach etwas Zeit immer die Chance auf einen Sieg haben.  \n\n"
            "Es verteilen sich anfangs alle Spieler zufällig an die Tische (Hier kann gerne unsere Hilfe im Tools Menü genutzt werden, um zufällige Paarungen zu erstellen.). "
            "Gespielt wird ab dem Zeitpunkt, wo der Trainer das Spiel freigibt."
            "Der Spieler, der in einer Partie nun 7 Punkte erzielt hat, rennt zum Trainer, und berichtet von seinem Erfolg. "
            "Der Verlierer am Tisch bleibt nun allerdings am Tisch stehen und behält seine Punkte aus dem Spiel für das nächste Spiel. \n\n"
            "Spielt Johannes also gegen Marie und Marie gewinnt mit 7:5, so so startet Johannes mit 5:0 in das nächste Spiel. "
            "Marie rennt zum Trainer und lässt sich einen Punkt gutschreiben. Sie wartet, bis jemand anderes ebenfalls mit seinem Spiel fertig wird und spielt nun gegen die Person, die gegen diese verloren hat. "
            "Diese Person startet ebenfalls mit dem Punktestand aus dem vorherigen Spiel. "
            "Der Trainer zählt die gewonnen Spiele des Spielers mit Hilfe der Strichliste in unserer App. "
            "Um den Trainer nicht zu verwirren mit zu vielen Spielern (Hab ich für Marie schon den Strich gemacht???), wird hier auch die Uhrzeit des letzten gewonnenen Spiels angezeigt. "
            "Viel Spaß beim Spielen! "
            ;
      default:
        return "Das hier ist ein super tolles Minigame. Mach dich bereit!";
    }
  }

  int get id {
    return this.index;
  }
}
