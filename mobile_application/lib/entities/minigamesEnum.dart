enum Minigame {
  alleGegenAlle,
  kaisertisch,
  siebenerTisch,
}

extension MiniGameTitle on Minigame {
  String get title {
    switch (this) {
      case Minigame.alleGegenAlle:
        return 'Alle gegen Alle';
      case Minigame.kaisertisch:
        return 'Kaisertisch';
      case Minigame.siebenerTisch:
        return '7er Tisch';
    }
  }

  int get id {
    return this.index; // Using the index as the ID, starting from 0
  }
}
