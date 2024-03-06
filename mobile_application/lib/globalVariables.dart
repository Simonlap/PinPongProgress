import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/uniqueGame.dart';

String? username = null;
String? useremail = null;
int? userid = null;
List<dynamic>? userroles = null;
String? jwtToken = null;

List<Player> player = [];
List<Group> groups = [];
List<UniqueGame> runningGames = [];

UniqueGame? currentUniqueGame = null; //Important: Only change value with method underneth!

String apiUrl = 'http://10.0.2.2:8080';

void updateUniqueGameInList(List<UniqueGame> uniqueGames, UniqueGame newCurrentUniqueGame) {
  currentUniqueGame = newCurrentUniqueGame;
  int indexToUpdate = uniqueGames.indexWhere((game) => game.id == newCurrentUniqueGame.id);
  if (indexToUpdate != -1) {
    uniqueGames[indexToUpdate] = newCurrentUniqueGame;
  } else {
    runningGames.add(newCurrentUniqueGame!);
    runningGames.sort((a, b) => b.startTime.compareTo(a.startTime));
  }
}

void deleteCurrentUniqueGame() {
  if (currentUniqueGame != null) {
    runningGames.removeWhere((game) => game.id == currentUniqueGame!.id);
    currentUniqueGame = null;
  }
}
