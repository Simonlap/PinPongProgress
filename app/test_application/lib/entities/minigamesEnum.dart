enum Minigame {
  alleGegenAlle,
  kaisertisch,
  siebenerTisch,
}

extension MiniGameTitle on Minigame {
  String get title {
    switch (this) {
      case Minigame.alleGegenAlle:
        return 'Alle gegen alle';
      case Minigame.kaisertisch:
        return 'Kaisertisch';
      case Minigame.siebenerTisch:
        return '7er Tisch';
    }
  }
}
